import 'package:ebike_app/views/dashboard_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lidar',
      theme: ThemeData(),
      builder: EasyLoading.init(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Lidar"),
          ),
          body: const DashBoardScreen()),
    );
  }
}
