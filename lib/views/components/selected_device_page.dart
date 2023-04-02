import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothData extends ConsumerWidget {
  const BluetoothData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBluetoothDataProvider).maybeMap(
        orElse: () => const Center(
              child: Text("wait...."),
            ),
        error: (value) => Center(
              // child: Text("Battery Power 70%\nBattery Temperature 41°F\nBattery Mac Address : 00:00:5e:00:53:af",textAlign: TextAlign.center,),
              child: Text(
                  "Please connect the esp with your bluetooth.\n\nerror : ${value.error}"),
            ),
        loaded: ((value) => Center(
                child: Column(
              children: [
                const Headline(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CardWidget(text: value.data),
                )
              ],
            ))));
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: const Text(
        'Counter',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
