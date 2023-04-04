import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ebike_app/helper/api_state.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothListNotifier
    extends StateNotifier<ApiState<List<BluetoothDevice>>> {
  BluetoothListNotifier() : super(const ApiState.initial()) {
    getPairedDevices();
  }
  final _bluetooth = FlutterBluePlus.instance;
  Future<void> getPairedDevices() async {
    state = const ApiState.loading();
    List<BluetoothDevice> devices = [];
    try {
      // await Permission.bluetooth.request();
      // await Permission.bluetoothConnect.request();
      // await Permission.bluetoothScan.request();
      // await Permission.bluetoothAdvertise.request();
      print("getPairedDevices start");
      await _bluetooth.bondedDevices.then((event) {
        devices = event;
        print("Paired devices list size ${event.length}");
        state = ApiState.loaded(data: devices);
      });
      print("getPairedDevices end");
    } catch (e) {
      print("getPairedDevices err\n ${e.toString()}");
      state = ApiState.error(
        error: e.toString(),
      );
    }
  }
}

class GetBluetoothDataNotifier extends StateNotifier<ApiState<String>> {
  GetBluetoothDataNotifier() : super(const ApiState.initial()) {
    // init();
    //readValue();
    print("GetBluetoothDataNotifier contructor start");
    getData();
  }
  final _bluetooth = FlutterBluePlus.instance;
  // String _messageBuffer = '';
  List<BluetoothDevice>? devicesList;
  List<BluetoothService>? bluetoothServices;
  String blueUuid = "";

  String messages = '';
  String _messageBuffer = '';
  late BluetoothDevice device;
  late BluetoothCharacteristic characteristic;

  Future<void> getData() async {
    try {
      print("getData start");
      state = const ApiState.loading();
      await Permission.bluetooth.request();
      await Permission.bluetoothConnect.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothAdvertise.request();
      print("scan start");
      // Scan for devices with a specific name or service UUID
      // List<ScanResult> scanResults = await FlutterBluePlus.instance
      //     .scan(timeout: const Duration(seconds: 5))
      //     .toList();
      await _bluetooth.bondedDevices.then((event) async {
        // devices = event;
        // print("Paired devices list size ${event.length}");
        // state = ApiState.loaded(data: devices);
        print('scan List size ${event.length}');
        if (event.isNotEmpty) {
          event
              .map((e) => print(
                  'Paired Device List :\nDevice id ${e.id}\nDevice name: ${e.name}'))
              .toList();
          // Find the desired device in the scan results
          // ScanResult desiredDevice = scanResults.first;
          // scanResults
          //     .map((e) => print(
          //         'Scan Device List :\nDevice id ${e.device.id}\nDevice name: ${e.device.name}'))
          //     .toList();

          BluetoothDevice desiredDevice = event.firstWhere(
              (result) => result.id.toString() == '0C:B8:15:C3:CE:1A',
              //(result) => result.device.id.toString() == '0CB815C3CE1A',
              orElse: () => throw Exception('Device not found'));

          // Connect to the device
          device = desiredDevice;
          print('device connect start');
          try {
            await device.connect();
            await FlutterBluePlus.instance.connectedDevices
                .then((value) => print('device connect ${value.length}'));
          } on Exception catch (e) {
            print('device error ${e.toString()}');
            // TODO
          }
          print('device connect end');

          // Discover the desired service and characteristic
          print('start2');
          List<BluetoothService> services = await device.discoverServices();
          print('start3');
          BluetoothService desiredService = services.firstWhere(
              (service) =>
                  service.uuid.toString() ==
                  '0000180f-0000-1000-8000-00805f9b34fb',
              orElse: () => throw Exception('Service not found'));

          characteristic = desiredService.characteristics.firstWhere(
              (characteristic) =>
                  characteristic.uuid.toString() ==
                  '00002a19-0000-1000-8000-00805f9b34fb',
              orElse: () => throw Exception('Characteristic not found'));

          // Subscribe to notifications from the characteristic
          await characteristic.setNotifyValue(true);
          characteristic.value.listen(_onCurrentDataReceived);
          print('Connected to the device');
        } else {
          print('No device fonund');
          state = const ApiState.loaded(
              data: "Please Connect the device throw\nbluetooth or, reload.");
        }
      });
    } catch (e) {
      state = ApiState.error(
        error: e.toString(),
      );
      print("err: $e");
    }
  }

  void _onCurrentDataReceived(List<int> data) {
    // Allocate buffer for parsed data
    print('Start _onCurrentDataReceived');
    int backspacesCounter = 0;
    for (var byte in data) {
      print('Start 2! $backspacesCounter');
      if (byte == 8 || byte == 127) {
        //print('Start 3! $backspacesCounter');
        backspacesCounter++;
        //print('Start 3.2! $backspacesCounter');
      }
    }
    print('Start 3.3! ${data.length}');
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    // print('Start 3.4! ${buffer.length}');
    int bufferIndex = buffer.length;
    //  print('Start 3.5! $bufferIndex');
    // Apply backspace control character
    backspacesCounter = 0;
    print('Start 4!');
    for (int i = data.length - 1; i >= 0; i--) {
      //print('Start 5! ${data.length}');
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
        // print('Start 5.2! $backspacesCounter');
      } else {
        if (backspacesCounter > 0) {
          print('Start 5.3! $backspacesCounter');
          backspacesCounter--;
        } else {
          print('Start 5.2! $bufferIndex:$i');
          //  bufferIndex = bufferIndex-1;
          buffer[--bufferIndex] = data[i];
          //int ind = --bufferIndex;
          // print('Start 5.2! $bufferIndex:$i');
          print('Start 5.2! $bufferIndex');
        }
      }
    }
    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    print('index1 $index!');
    if (~index != 0) {
      // print('index2 $index!');
      messages = backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString.substring(0, index);
      // if (_messageBuffer.isNotEmpty) {
      //   print('is not empty1 $_messageBuffer ...');
      //   state = ApiState.loaded(data: _messageBuffer);
      // }
      _messageBuffer = dataString.substring(index);
      print('buffer1 $_messageBuffer!');
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
      // print('index $index!');
      //_messageBuffer = dataString.substring(index+1);
      print('buffer2 output $_messageBuffer ...');
      if (_messageBuffer.isNotEmpty) {
        print('is not empty 2 $_messageBuffer ...');
        state = ApiState.loaded(data: _messageBuffer);
      }
    }
  }

  Future<void> writeValue(String value) async {
    final list = utf8.encode(value);
    BluetoothService? bluetoothService = bluetoothServices!.first;
    BluetoothCharacteristic? bluetoothCharacteristic =
        bluetoothService.characteristics.first;
    // BluetoothService? bluetoothService = bluetoothServices!
    //     .firstWhere((element) => element.uuid.toString() == blueUuid);
    // BluetoothCharacteristic? bluetoothCharacteristic = bluetoothService
    //     .characteristics
    //     .firstWhere((element) => element.uuid.toString() == blueUuid);

    bluetoothCharacteristic.write(list);
  }

  Future<void> readValue() async {
    try {
      await _bluetooth.connectedDevices.then((event) async {
        // blueUuid = event.first.id.id;
        print("read devices connected size ${event.length}");
        if (event.isNotEmpty) {
          // event.first;
          await event.first.services.first.then((value) {
            bluetoothServices = value;
            BluetoothService? bluetoothService = bluetoothServices?.first;
            BluetoothCharacteristic? bluetoothCharacteristic =
                bluetoothService?.characteristics.first;
            List<int>? utf8Response;
            bluetoothCharacteristic?.read().asStream().listen((data) {
              utf8Response = data;
              String readableValue = utf8.decode(utf8Response ?? []);
              state = ApiState.loaded(data: readableValue);
            }).onDone(() {
              print("Disconnected");
              state = const ApiState.loaded(data: "Connect the esp");
            });
          });
        } else {
          state = const ApiState.loaded(data: "Connect the esp");
        }
        print("object");
      });
    } on Exception catch (e) {
      state = ApiState.error(error: e.toString());
      print("error is ${e.toString()}");
    }
  }
  // Future initBleList() async {
  //   _bluetooth.connectedDevices.asStream().listen((devices) {
  //     for (var device in devices) {
  //       _addDeviceTolist(device);
  //     }
  //   });
  //   _bluetooth.scanResults.listen((scanResults) {
  //     for (var result in scanResults) {
  //       _addDeviceTolist(result.device);
  //     }
  //   });
  //   _bluetooth.startScan();
  // }

  // void _addDeviceTolist(BluetoothDevice device) {
  //   if (!_devicesList!.contains(device)) {
  //     _devicesList!.add(device);
  //   }
  // }
  // Future<void> reload() async {
  //   try {
  //     if (!connection.isConnected) {
  //       print("reload ${connection.input!.isBroadcast}");
  //       getData();
  //     }
  //   } on Exception catch (e) {
  //     print("err: $e");
  //     state = ApiState.error(
  //       error: e.toString(),
  //     );
  //   }
  // }

  // Future<void> getData() async {
  //   try {
  //     state = const ApiState.loading();
  //     print('Connecting');

  //     connection = await BluetoothConnection.toAddress("0C:B8:15:C3:CE:1A");
  //     // await BluetoothConnection.toAddress("0:B9:7E:D0:75:C2");
  //     print('Connected to the device');
  //     List<String> totalData = [];
  //     connection.input?.listen(_onCurrentDataReceived).onDone(() {
  //       print('Disconnecting!');
  //       // EasyLoading.showError("Connection lost!!");
  //     });
  //   } catch (e) {
  //     EasyLoading.showError("Something went wrong!"); //Shows Error PopUp
  //     state = ApiState.error(
  //       error: e.toString(),
  //     );
  //     print("err: $e");
  //   }
  // }

  // void _onCurrentDataReceived(Uint8List data) {
  //   // Allocate buffer for parsed data
  //   // print('Start 1!');
  //   int backspacesCounter = 0;
  //   for (var byte in data) {
  //     //print('Start 2! $backspacesCounter');
  //     if (byte == 8 || byte == 127) {
  //       //print('Start 3! $backspacesCounter');
  //       backspacesCounter++;
  //       //print('Start 3.2! $backspacesCounter');
  //     }
  //   }
  //   //print('Start 3.3! ${data.length}');
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   // print('Start 3.4! ${buffer.length}');
  //   int bufferIndex = buffer.length;
  //   //  print('Start 3.5! $bufferIndex');
  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   //print('Start 4!');
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     //print('Start 5! ${data.length}');
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //       // print('Start 5.2! $backspacesCounter');
  //     } else {
  //       if (backspacesCounter > 0) {
  //         // print('Start 5.3! $backspacesCounter');
  //         backspacesCounter--;
  //       } else {
  //         //print('Start 5.2! $bufferIndex:$i');
  //         //  bufferIndex = bufferIndex-1;
  //         buffer[--bufferIndex] = data[i];
  //         //int ind = --bufferIndex;
  //         // print('Start 5.2! $bufferIndex:$i');
  //         // print('Start 5.2! $bufferIndex');
  //       }
  //     }
  //   }
  //   // Create message if there is new line character
  //   String dataString = String.fromCharCodes(buffer);
  //   int index = buffer.indexOf(13);
  //   //print('index1 $index!');
  //   if (~index != 0) {
  //     // print('index2 $index!');
  //     messages = backspacesCounter > 0
  //         ? _messageBuffer.substring(
  //             0, _messageBuffer.length - backspacesCounter)
  //         : _messageBuffer + dataString.substring(0, index);
  //     // if (_messageBuffer.isNotEmpty) {
  //     //   print('is not empty1 $_messageBuffer ...');
  //     //   state = ApiState.loaded(data: _messageBuffer);
  //     // }
  //     _messageBuffer = dataString.substring(index);
  //     //print('buffer $_messageBuffer!');
  //   } else {
  //     _messageBuffer = (backspacesCounter > 0
  //         ? _messageBuffer.substring(
  //             0, _messageBuffer.length - backspacesCounter)
  //         : _messageBuffer + dataString);
  //     // print('index $index!');
  //     //_messageBuffer = dataString.substring(index+1);
  //     // print('buffer output $_messageBuffer ...');
  //     if (_messageBuffer.isNotEmpty) {
  //       // print('is not empty 2 $_messageBuffer ...');
  //       state = ApiState.loaded(data: _messageBuffer);
  //     }
  //   }
  // }
}
