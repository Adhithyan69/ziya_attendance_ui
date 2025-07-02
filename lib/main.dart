import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/forgot_controller.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/login_controller.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/signUp_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/holiday_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/leave_dashboard_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/leave_status_controller.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/leaves_Request_controller.dart';
import 'package:ziya_attendance_ui/controller/notification_controller.dart';
import 'package:ziya_attendance_ui/controller/profile_controller.dart';
import 'package:ziya_attendance_ui/controller/search_controller.dart';
import 'package:ziya_attendance_ui/controller/task_controller.dart';
import 'package:ziya_attendance_ui/views/authentication/signUp_screen.dart';
import 'package:ziya_attendance_ui/views/bottom_navigationBar.dart';
import 'controller/checkin_card_controller.dart';
import 'controller/dashboard_controllers/attendance_controller.dart';
import 'controller/dashboard_controllers/dash_board_controller.dart';
import 'controller/dashboard_controllers/payslip_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (context) => AttendanceController()),
        ChangeNotifierProvider(create: (context) =>HolidayController()),
        ChangeNotifierProvider(create: (context) =>LeaveStatusController()),
        ChangeNotifierProvider(create: (context) =>PayslipController()),
        ChangeNotifierProvider(create: (context) =>ProfileController()),
        ChangeNotifierProvider(create: (context) =>NotificationController()),
        ChangeNotifierProvider(create: (context) =>SearchSheetController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? const BottomNavigation() : const SignUpPage(),
    );
  }
}
