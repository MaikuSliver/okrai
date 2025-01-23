import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mainscreens/Home.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Enable offline persistence for Firestore
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Open a box for your app's preferences
  await Hive.openBox('appBox');
  
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
          child: Home(),
        ),
      ),
    );
  }
}


