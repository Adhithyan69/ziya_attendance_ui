import 'package:flutter/material.dart';

class ResetPasswordController extends ChangeNotifier {
  String _newPassword = "";
  String _confirmPassword = "";
  String? _errorMessage;
  bool _isLoading = false;

  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void onNewPasswordChanged(String value) {
    _newPassword = value;
    notifyListeners();
  }

  void onConfirmPasswordChanged(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  Future<void> resetPassword(Function onSuccess) async {
    if (_newPassword.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = "Please fill all fields";
      notifyListeners();
      return;
    }

    if (_newPassword != _confirmPassword) {
      _errorMessage = "Passwords do not match";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    onSuccess();
  }
}
