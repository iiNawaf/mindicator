import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var moodResult = 0.0;

  Future<void> loadModel() async {
    final interpreter = await Interpreter.fromAsset('model.tflite');
    var input = [
      [40.0, 1000.0, 8.0]
    ];
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    print(output);
    moodResult = output[0][0];
  }

  @override
  Widget build(BuildContext context) {
    loadModel();
    return Scaffold(
      body: Center(
        child: Text(moodResult.round().toString()),
      ),
    );
  }
}
