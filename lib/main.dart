import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/screens/home_screen.dart';
import 'package:ziya_attendance_ui/screens/bottom_navigationBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNavigation(),
    );
  }
}

