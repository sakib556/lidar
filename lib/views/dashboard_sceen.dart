import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:ebike_app/views/components/bluetooth_devices_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          await ref.read(getBluetoothDataProvider.notifier).reload();
        },
        child: const BluetoothDevicesPage());
  }
}
