import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDevice extends StatelessWidget {
  const BleDevice(
      {Key? key,
      required this.device,
      required this.isConnected,
      required this.onPressed})
      : super(key: key);
  final BluetoothDevice? device;
  final bool isConnected;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: onTap(),
      leading: const Icon(Icons.devices),
      title: Text(device == null ? "BLE" : device!.name),
      subtitle: Text(device == null ? "Connect now" : device!.id.id.toString()),
      trailing: isConnected
          ? const Text("Connected")
          : ElevatedButton(
              child: const Text('Connect'),
              onPressed: () async {
                onPressed();
              },
            ),
    );
  }
}

