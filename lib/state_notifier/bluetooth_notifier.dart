import 'dart:async';
import 'dart:convert';
import 'package:ebike_app/helper/api_state.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      print("get connected devices start");
      _bluetooth.bondedDevices.then((value) {
        devices.clear();
        for (var element in value) {
          print("Paired device id ${element.id}");
          print("Paired device name ${element.id}");
          devices.add(element);
          state = ApiState.loaded(data: devices);
        }
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
    print("GetBluetoothDataNotifier contructor start");
    getData();
  }
  final _bluetooth = FlutterBluePlus.instance;
  List<BluetoothDevice>? devicesList;
  List<BluetoothService>? bluetoothServices;
  String blueUuid = "";
  String messages = '';
  late BluetoothDevice device;
  late BluetoothCharacteristic characteristic;
  bool isDiscovering = false;
  StreamSubscription<bool>? streamIsDiscovering;
  StreamSubscription<List<int>>? streamGetData;
  Future<void> getData() async {
    try {
      print("getData start");
      state = const ApiState.loading();
      print("scan start");
      await _bluetooth.bondedDevices.then((event) async {
        print('bondedDevices List size ${event.length}');
        if (event.isNotEmpty) {
          event
              .map((e) => print(
                  'Paired Device List :\nDevice id ${e.id}\nDevice name: ${e.name}'))
              .toList();

          BluetoothDevice desiredDevice = event.firstWhere(
              (result) => result.name.toString() == 'LIDAR',
              orElse: () => throw Exception('Device not found'));
          device = desiredDevice;
          try {
            streamIsDiscovering =
                device.isDiscoveringServices.listen((event) async {
              isDiscovering = event;
              print('called discover $isDiscovering');
            });
            if (!isDiscovering) {
              print('device connect start $isDiscovering');
              await device.connect();
            }
          } on Exception catch (e) {
            print('device error ${e.toString()}');
            state = const ApiState.loading();
          }
          print('device connect end');

          // Discover the desired service and characteristic
          List<BluetoothService> services = await device.discoverServices();
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
          streamGetData = characteristic.read().asStream().listen(_readValue);
          print('Get data from the device');
        } else {
          print('No device fonund');
          state = const ApiState.loaded(
              data:
                  "Please paired / connect the device\nthrow bluetooth or, reload.");
        }
      });
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

  @override
  void dispose() {
    if (streamIsDiscovering != null) {
      streamIsDiscovering!.cancel();
    }
    if (streamGetData != null) {
      streamGetData!.cancel();
    }
    super.dispose();
  }
}
