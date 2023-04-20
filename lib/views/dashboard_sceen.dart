import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:ebike_app/views/components/show_bluetooth_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () async {
              print("refresh start");
              await ref
                  .read(bluetoothDeviceListProvider.notifier)
                  .getPairedDevices();
              await ref.read(getBluetoothDataProvider.notifier).getData();
              print("refresh end");
            },
            child: const Text("Refresh")),
        const ShowBluetoothDevices(),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
