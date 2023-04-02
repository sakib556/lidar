import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:ebike_app/views/components/bluetooth_devices_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothDevicesPage extends ConsumerWidget {
  const BluetoothDevicesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(bluetoothDeviceListProvider).maybeMap(
        orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (value) => Center(
              child: Text("error $value"),
            ),
        loaded: ((deviceList) {
          return deviceList.data.isNotEmpty
              ? BluetoothDeviceList(
                  devices: deviceList.data,
                )
              : const Center(
                  child: Text("No bluetooth paired devices found"),
                );
        }));
  }
}
