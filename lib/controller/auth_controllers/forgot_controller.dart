import 'package:flutter/material.dart';
import '../../services/auth_services.dart';

class ForgotPasswordController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> resetPassword({
    required String email,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      scaffoldKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Password reset email sent")),
      );
      onSuccess();
    } catch (e) {
      onError("Error: ${e.toString()}");
    }
  }
}
