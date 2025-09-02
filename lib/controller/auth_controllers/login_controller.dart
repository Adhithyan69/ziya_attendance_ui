import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: const Text("Success"),
              content: const Text(
                "Login successful!",
                style: TextStyle(color: Colors.green),
              ),
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
      onError("Login failed: ${e.toString()}");
    }
  }

}