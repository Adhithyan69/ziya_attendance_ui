import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        builder: (ctx) => AlertDialog(
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

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required Function(String) onError,
    required VoidCallback onSuccess,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection('users').doc(result.user!.uid).set({
        'uid': result.user!.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      onSuccess();
    } catch (e) {
      onError("Sign-up failed: ${e.toString()}");
    }
  }
}
