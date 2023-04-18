import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ebike_app/helper/api_state.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:permission_handler/permission_handler.dart';

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
      _bluetooth.connectedDevices.then((event) {
        devices = event;
        print("connected devices list size ${devices.length}");

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
  BluetoothDevice? device;
  late BluetoothCharacteristic characteristic;

  Future<void> getData() async {
    try {
      print("getData start");
      state = const ApiState.loading();

      print("scan start");
      // Scan for devices with a specific name or service UUID
      List<ScanResult> scanResults = await FlutterBluePlus.instance
          .scan(timeout: const Duration(seconds: 5))
          .toList();
      print("scan end");
      print('scan List size ${scanResults.length}');
      for (var element in scanResults) {
        print(
            'scan Device:\nDevice id ${element.device.id.id}\nDevice name: ${element.device.name}');
        if (element.device.name == "LIDAR") {
          device = element.device;
          print('lidar found');
        }
      }
      if (device != null) {
        // Connect to the device
        print('device connect start');
        await device!.connect();
        print('device connect end');

        // Discover the desired service and characteristic
        print('start2');
        List<BluetoothService> services = await device!.discoverServices();
        print('start3');
        BluetoothService desiredService = services.firstWhere(
            (service) =>
                service.uuid.toString() ==
                '4fafc201-1fb5-459e-8fcc-c5c9c331914b',
            orElse: () => throw Exception('Service not found'));

        characteristic = desiredService.characteristics.firstWhere(
            (characteristic) =>
                characteristic.uuid.toString() ==
                'beb5483e-36e1-4688-b7f5-ea07361b26a8',
            orElse: () => throw Exception('Characteristic not found'));
        // Subscribe to notifications from the characteristic
        await characteristic.setNotifyValue(true);
        characteristic.read().asStream().listen(_readValue);
        print('Connected to the device');
      } else {
        print('LIDAR not found');
        state = const ApiState.loaded(
            data: "Please Connect the device throw\nbluetooth or, reload.");
      }
    } catch (e) {
      state = ApiState.error(
        error: e.toString(),
      );
      print("err: $e");
    }
  }

  Future<void> writeValue(String value) async {
    final list = utf8.encode(value);
    characteristic.write(list);
    print("end");
  }

  void _readValue(List<int> utf8Response) async {
    try {
      print("read values");
      String readableValue = utf8.decode(utf8Response);
      state = ApiState.loaded(data: readableValue);
      print("end");
    } on Exception catch (e) {
      state = ApiState.error(error: e.toString());
      print("error is ${e.toString()}");
    }
  }

  // @override
  // void dispose() {
  //   if (streamIsDiscovering != null) {
  //     streamIsDiscovering!.cancel();
  //   }
  //   if (streamGetData != null) {
  //     streamGetData!.cancel();
  //   }
  //   super.dispose();
  // }

  // void _onCurrentDataReceived(List<int> data) {
  //   // Allocate buffer for parsed data
  //   print('Start _onCurrentDataReceived');
  //   int backspacesCounter = 0;
  //   for (var byte in data) {
  //     print('Start 2! $backspacesCounter');
  //     if (byte == 8 || byte == 127) {
  //       //print('Start 3! $backspacesCounter');
  //       backspacesCounter++;
  //       //print('Start 3.2! $backspacesCounter');
  //     }
  //   }
  //   print('Start 3.3! ${data.length}');
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   // print('Start 3.4! ${buffer.length}');
  //   int bufferIndex = buffer.length;
  //   //  print('Start 3.5! $bufferIndex');
  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   print('Start 4!');
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     //print('Start 5! ${data.length}');
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //       // print('Start 5.2! $backspacesCounter');
  //     } else {
  //       if (backspacesCounter > 0) {
  //         print('Start 5.3! $backspacesCounter');
  //         backspacesCounter--;
  //       } else {
  //         print('Start 5.2! $bufferIndex:$i');
  //         //  bufferIndex = bufferIndex-1;
  //         buffer[--bufferIndex] = data[i];
  //         //int ind = --bufferIndex;
  //         // print('Start 5.2! $bufferIndex:$i');
  //         print('Start 5.2! $bufferIndex');
  //       }
  //     }
  //   }
  //   // Create message if there is new line character
  //   String dataString = String.fromCharCodes(buffer);
  //   int index = buffer.indexOf(13);
  //   print('index1 $index!');
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
  //     print('buffer1 $_messageBuffer!');
  //   } else {
  //     _messageBuffer = (backspacesCounter > 0
  //         ? _messageBuffer.substring(
  //             0, _messageBuffer.length - backspacesCounter)
  //         : _messageBuffer + dataString);
  //     // print('index $index!');
  //     //_messageBuffer = dataString.substring(index+1);
  //     print('buffer2 output $_messageBuffer ...');
  //     if (_messageBuffer.isNotEmpty) {
  //       print('is not empty 2 $_messageBuffer ...');
  //       state = ApiState.loaded(data: _messageBuffer);
  //     }
  //   }
  // }
}
