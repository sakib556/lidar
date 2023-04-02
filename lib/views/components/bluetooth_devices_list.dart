import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:ebike_app/views/components/selected_device_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                title: Text(device.name ?? "Unknown device"),
                subtitle: Text(device.address.toString()),
                trailing: ElevatedButton(
                  child: const Text('Connected'),
                  onPressed: () async {
                    //  ref.read(getBluetoothDataProvider.notifier).connectDevice(device, context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SelectedDevicePage();
                        },
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
        const SizedBox(
          height: 100,
        ),
        const Center(child: BluetoothData())
      ],
    );
  }
}

class SelectedDevicePage extends ConsumerWidget {
  const SelectedDevicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Esp32 Bluetooth"),
      ),
      body: ref.watch(getBluetoothDataProvider).maybeMap(
          orElse: () => const Center(
                child: Text("wait...."),
              ),
          error: (value) => Center(
                // child: Text("Battery Power 70%\nBattery Temperature 41°F\nBattery Mac Address : 00:00:5e:00:53:af",textAlign: TextAlign.center,),
                child: Text(
                    "Please connect the esp with your bluetooth.\n\nerror : ${value.error}"),
              ),
          loaded: ((value) =>
              Center(child: Text("Battery Mac Address : ${value.data}")))),
    );
  }
}
