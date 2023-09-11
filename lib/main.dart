import 'package:editor/screens/home_screen.dart';
import 'package:editor/screens/splash_screen.dart';
import 'package:editor/src/crop_controller.dart';
import 'package:editor/src/crop_image.dart';
import 'package:editor/src/crop_rotation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

