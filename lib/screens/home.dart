import 'package:flutter/material.dart';
import 'package:mindicator/providers/tensorflow_provider.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var moodResult = 0.0;
  var input = [
    [65.0, 10000.0, 10.0]
  ];
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    final tfProvider = Provider.of<TensorflowProvider>(context, listen: false);
    await tfProvider.loadMoodDetectionModel(input);
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tfProvider = Provider.of<TensorflowProvider>(context, listen: false);
    final moodResult = tfProvider.output[0][0];
    return Scaffold(
      body: Center(
        child: Text(moodResult.round().toString()),
      ),
    );
  }
}
