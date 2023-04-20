import 'package:ebike_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _getPermission();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<void> _getPermission() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Permission.locationWhenInUse.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//iOS specific code
  } else {
//web or desktop specific code
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getPermission();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIDAR',
      theme: ThemeData(),
      builder: EasyLoading.init(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("LIDAR"),
          ),
          body:  const HomeScreen()),
    );
  }
}
