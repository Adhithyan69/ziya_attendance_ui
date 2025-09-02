import 'package:flutter/material.dart';
import '../../controller/auth_controllers/signUp_controller.dart';
import '../../widgets/background_circles_widget.dart';
import '../../widgets/login_textFields.dart';
import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignUpController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                      const Text("ZiyaAttend",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text("Create an account",
                          style: TextStyle(color: Colors.green, fontSize: 18)),
                      const SizedBox(height: 32),
                      LoginTextFields(
                        hint: "Name",
                        controller: nameController,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Name is required";
                          if (v.length < 3) return "Min 3 characters";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LoginTextFields(
                        hint: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Email required";
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(v)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LoginTextFields(
                        hint: "Mobile Number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Mobile required";
                          if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                            return "Enter a valid 10-digit number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LoginTextFields(
                        hint: "Password",
                        controller: passwordController,
                        obscureText: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Password required";
                          }
                          if (v.length < 6) return "Min 6 characters";
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => _controller.signUp(
                            context: context,
                            formKey: _formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                            nameController: nameController,
                            phoneController: phoneController,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Sign Up",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                            ),
                            child: const Text("Login",
                                style: TextStyle(color: Colors.green)),
                          ),
                        ],
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
