import 'dart:async';
import 'package:ebike_app/views/components/ble_device.dart';
import 'package:ebike_app/views/components/show_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  StreamSubscription<List<int>>? _streamSubscription;
  bool isConnected = false;
  String _counterValue = "0";

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  BluetoothDevice? targetDevice;
  BluetoothCharacteristic? targetCharacteristic;

  @override
  void initState() {
    super.initState();
    scanDevices();
  }

  Future<void> scanDevices() async {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    flutterBlue.scanResults.listen((scanResultList) {
      for (ScanResult scanResult in scanResultList) {
        print(scanResult.device.name);
        if (scanResult.device.name.contains("LIDAR")) {
          flutterBlue.stopScan();
          setState(() {
            targetDevice = scanResult.device;
          });
          break;
        }
      }

      if (targetDevice == null) {
        print("Device not found");
        setState(() {
          _counterValue =
              "Device not found.Try to connect again or, reset the ESP.";
        });
      } else {
        print("Device found, connecting...");

        connectToDevice();
      }
    });
  }

  Future<void> connectToDevice() async {
    await targetDevice!.connect();
    print("Device connected");

    List<BluetoothService> services = await targetDevice!.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            targetCharacteristic = characteristic;
            setNotification();
            setState(() {
              isConnected = true;
            });
          }
        }
      }
    }
  }

  void setNotification() async {
    if (targetCharacteristic != null) {
      await targetCharacteristic!.setNotifyValue(true);
      _streamSubscription =
          targetCharacteristic!.value.listen((value) => setState(() {
                _counterValue = String.fromCharCodes(value);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              BleDevice(
                  device: targetDevice,
                  isConnected: isConnected,
                  onPressed: () {
                    scanDevices();
                  }),
              const SizedBox(
                height: 20,
              ),
              ShowCounter(counterValue: _counterValue),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    setNotification();
                  },
                  child: const Text("Reset now"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
    targetDevice?.disconnect();
  }
}
