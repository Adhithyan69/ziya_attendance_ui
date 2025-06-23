import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Email Sent"),
          content: const Text("A password reset link has been sent to your email."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onSuccess();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      onError("Error: ${e.toString()}");
    }
  }
}
