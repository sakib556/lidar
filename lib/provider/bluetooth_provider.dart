
import 'package:ebike_app/state_notifier/bluetooth_notifier.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ebike_app/helper/api_state.dart';

final bluetoothDeviceListProvider =
    StateNotifierProvider<BluetoothListNotifier, ApiState<List<BluetoothDevice>>>(
        (ref) => BluetoothListNotifier());
final getBluetoothDataProvider =
    StateNotifierProvider<GetBluetoothDataNotifier, ApiState<String>>(
        (ref) => GetBluetoothDataNotifier());

// final batteryTemperatureProvider =
//     StateNotifierProvider<BatteryTemperatureNotifier, ApiState<double>>(
//         (ref) => BatteryTemperatureNotifier());