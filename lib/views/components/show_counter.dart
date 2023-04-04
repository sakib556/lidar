import 'package:ebike_app/provider/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowCounter extends StatelessWidget {
  const ShowCounter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Headline(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: const Center(
              child:
                  Padding(padding: EdgeInsets.all(10.0), child: BluetoothTextData()),
            ),
          ),
        )
      ],
    ));
  }
}

class BluetoothTextData extends ConsumerWidget {
  const BluetoothTextData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBluetoothDataProvider).maybeMap(
        orElse: () => _textWidget("Please wait......"),
        error: (value) =>
            _textWidget("Connection Failed.\nError :\n${value.error}"),
        loaded: ((value) => _textWidget(value.data)));
  }

  Widget _textWidget(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
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
