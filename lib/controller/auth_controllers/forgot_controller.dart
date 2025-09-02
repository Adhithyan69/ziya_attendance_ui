import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      onSuccess();
    } catch (e) {
      onError("Error: ${e.toString()}");
    }
  }
}
