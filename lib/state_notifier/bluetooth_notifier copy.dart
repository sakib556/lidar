import 'dart:async';
import 'dart:convert';
import 'package:ebike_app/helper/api_state.dart';
import 'package:ebike_app/models/bluetooth_device_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothListNotifier
    extends StateNotifier<ApiState<List<BluetoothDevice>>> {
  BluetoothListNotifier() : super(const ApiState.initial()) {
    getPairedDevices();
  }
  final _bluetooth = FlutterBluetoothSerial.instance;
  String bluetoothAdress = "";
  Future<void> getPairedDevices() async {
    state = const ApiState.loading();
    List<BluetoothDevice> devices = [];
    try {
      devices = await _bluetooth.getBondedDevices();
      state = ApiState.loaded(data: devices);
    } catch (e) {
      print(e.toString());
      // errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: e.toString(),
      );
    }
  }
}

class GetBluetoothDataNotifier extends StateNotifier<ApiState<String>> {
  GetBluetoothDataNotifier() : super(const ApiState.initial()) {
    getData();
  }
  String messages = "";
  String _messageBuffer = '';
  late BluetoothConnection connection;
  Future<void> getData() async {
    try {
      state = const ApiState.loading();
      print('Connecting');

      connection = await BluetoothConnection.toAddress("0C:B8:15:C3:CE:1A");
      // await BluetoothConnection.toAddress("0:B9:7E:D0:75:C2");
      print('Connected to the device');
      List<String> totalData = [];
      connection.input?.listen(_onCurrentDataReceived).onDone(() {
        print('Disconnecting!');
        // EasyLoading.showError("Connection lost!!");
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong!"); //Shows Error PopUp
      state = ApiState.error(
        error: e.toString(),
      );
      print("err: $e");
    }
  }

  void _onCurrentDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    // print('Start 1!');
    int backspacesCounter = 0;
    for (var byte in data) {
      //print('Start 2! $backspacesCounter');
      if (byte == 8 || byte == 127) {
        //print('Start 3! $backspacesCounter');
        backspacesCounter++;
        //print('Start 3.2! $backspacesCounter');
      }
    }
    //print('Start 3.3! ${data.length}');
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    // print('Start 3.4! ${buffer.length}');
    int bufferIndex = buffer.length;
    //  print('Start 3.5! $bufferIndex');
    // Apply backspace control character
    backspacesCounter = 0;
    //print('Start 4!');
    for (int i = data.length - 1; i >= 0; i--) {
      //print('Start 5! ${data.length}');
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
        // print('Start 5.2! $backspacesCounter');
      } else {
        if (backspacesCounter > 0) {
          // print('Start 5.3! $backspacesCounter');
          backspacesCounter--;
        } else {
          //print('Start 5.2! $bufferIndex:$i');
          //  bufferIndex = bufferIndex-1;
          buffer[--bufferIndex] = data[i];
          //int ind = --bufferIndex;
          // print('Start 5.2! $bufferIndex:$i');
          // print('Start 5.2! $bufferIndex');
        }
      }
    }
    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    //print('index1 $index!');
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
      //print('buffer $_messageBuffer!');
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
      // print('index $index!');
      //_messageBuffer = dataString.substring(index+1);
      // print('buffer output $_messageBuffer ...');
      if (_messageBuffer.isNotEmpty) {
        // print('is not empty 2 $_messageBuffer ...');
        state = ApiState.loaded(data: _messageBuffer);
      }
    }
  }

  Future<void> sentData(String data) async {
    try {
      final list = utf8.encode(data);
      connection.output.add(Uint8List.fromList(list));
      await connection.output.allSent
          .then((value) => print("send data: ${list.toString()}"));
    } on Exception catch (e) {
      print("err: $e");
    }
  }

  Future<void> reload() async {
    try {
      if (!connection.isConnected) {
        print("reload ${connection.input!.isBroadcast}");
        getData();
      }
    } on Exception catch (e) {
      print("err: $e");
      state = ApiState.error(
        error: e.toString(),
      );
    }
  }
}

class BluetoothNotifier extends StateNotifier<ApiState<String>> {
  BluetoothNotifier() : super(const ApiState.initial());

  Future<void> connectDevice(
      BluetoothDevice _device, BuildContext context) async {
    try {
      await BluetoothConnection.toAddress(_device.address).then((_connection) {
        print('Connection input ${_connection.input.toString()}');
        print('Connection o/p ${_connection.output.toString()}');
        // connection.input.listen(null).onDone(() {
        EasyLoading.showSuccess("Connected");
        // });
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong!"); //Shows Error PopUp
      state = ApiState.error(
        error: e.toString(),
      );
    }
  }
}

class BluetoothListNotifierOld
    extends StateNotifier<ApiState<List<DeviceWithAvailability>>> {
  BluetoothListNotifierOld() : super(const ApiState.initial()) {
    allDevices();
  }
  StreamSubscription<BluetoothDiscoveryResult>? _stream;
  // final stream;
  Future<void> allDevices() async {
    try {
      state = const ApiState.loading();
      print("start ");
      List<DeviceWithAvailability> devices = [];
      print("start 1");

      print("start 2");

      print("start 3");
      _stream = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = DeviceAvailability.yes;
            _device.rssi = r.rssi;
            print("start 4");
          }
        }
      });
      FlutterBluetoothSerial.instance.getBondedDevices().then((bondedDevices) {
        print("start 5");
        print(
            "devices:  ${bondedDevices.length}\ndevice1:  ${bondedDevices.first.name}");
        devices = bondedDevices
            .map(
              (device) => DeviceWithAvailability(
                device: device,
                availability: DeviceAvailability.yes,
              ),
            )
            .toList();
        state = ApiState.loaded(data: devices);
      });
      print("start 6");

      print("start 7");

      print("start 8");
    } catch (e) {
      print(e.toString());
      // errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    if (_stream != null) {
      _stream!.cancel();
    }
    super.dispose();
  }
}
