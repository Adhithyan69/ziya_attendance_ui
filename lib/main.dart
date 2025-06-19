import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ziya_attendance_ui/controller/auth_controllers/forgot_controller.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/login_controller.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/signUp_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/leave_dashboard_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/leaves_Request_controller.dart';
import 'package:ziya_attendance_ui/controller/task_controller.dart';
import 'package:ziya_attendance_ui/views/authentication/login_screen.dart';
import 'package:ziya_attendance_ui/views/authentication/signUp_screen.dart';
import 'package:ziya_attendance_ui/views/bottom_navigationBar.dart';
import 'controller/checkin_card_controller.dart';
import 'controller/dashboard_controllers/dash_board_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => DashboardController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordController()),
        ChangeNotifierProvider(create: (context) => LeaveRequestController()),
        ChangeNotifierProvider(create: (context) => LeaveDashboardController()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const BottomNavigation() : const SignUpPage(),
    );
  }
}
