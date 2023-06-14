import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TensorflowProvider with ChangeNotifier {
  var output = List.filled(1, 0).reshape([1, 1]);

  Future<void> loadMoodDetectionModel(List<List<double>> input) async {
    final interpreter = await Interpreter.fromAsset('model.tflite');
    if (interpreter.isAllocated) {
      interpreter.run(input, output);
    }
  }
}
