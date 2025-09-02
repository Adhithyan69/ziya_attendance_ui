import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/views/authentication/verify_otp_screen.dart';
import '../../controller/auth_controllers/forgot_controller.dart';
import '../../widgets/background_circles_widget.dart';
import '../../widgets/login_textFields.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordController _controller = ForgotPasswordController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      _controller.resetPassword(
        context: context,
        email: _emailController.text.trim(),
        onSuccess: () {
          setState(() => _isLoading = false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                email: _emailController.text.trim(),
                onVerified: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("OTP Verified!")),
                  );
                },
              ),
            ),
          );
        },
        onError: (message) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundCircles(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "ZiyaAttend",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      LoginTextFields(
                        controller: _emailController,
                        hint: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Reset Password",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
