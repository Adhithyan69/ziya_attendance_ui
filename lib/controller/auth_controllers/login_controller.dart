import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_services.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> loginUser({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await _authService.signIn(email, password);
      scaffoldKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      onSuccess();
    } catch (e) {
      onError("Login failed: ${e.toString()}");
    }
  }
}
