import 'package:flutter/material.dart';
import 'package:okrai/forecast/predictyield.dart';
import 'mainscreens/Home.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DoubleTapToExit(
          snackBar: SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: PredictYield(),
        ),
      ),
    );
  }
}


