import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ShowBluetoothDevices extends ConsumerWidget {
  const ShowBluetoothDevices({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(bluetoothDeviceListProvider).maybeMap(
        orElse: () => const CircularProgressIndicator(),
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

class BluetoothDeviceList extends ConsumerWidget {
  final List<BluetoothDevice> devices;

  const BluetoothDeviceList({Key? key, required this.devices})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: [
        ...devices
            .map(
              (device) => ListTile(
                // onTap: onTap(),
                leading: const Icon(Icons.devices),
                title: Text(device.name),
                subtitle: Text(device.id.id.toString()),
                trailing: ElevatedButton(
                  child: const Text('Paired'),
                  onPressed: () async {
                    //  ref.read(getBluetoothDataProvider.notifier).connectDevice(device, context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const SelectedDevicePage();
                    //     },
                    //   ),
                    // );
                  },
                ),
              ),
            )
            .toList(),

      ],
    );
  }
}


