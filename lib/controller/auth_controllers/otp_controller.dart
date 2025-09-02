import 'dart:math';
import 'package:flutter/material.dart';

class OtpController extends ChangeNotifier {
  String _otp = "";
  bool _isLoading = false;
  String? _errorMessage;
  String _dummyOtp = "3511";

  String get otp => _otp;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get dummyOtp => _dummyOtp;

  void onOtpChange(String newOtp) {
    if (newOtp.length <= 4) {
      _otp = newOtp;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(Function onSuccess) async {
    if (_otp.length < 4) {
      _errorMessage = "Enter 4 digit code";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    if (_otp == _dummyOtp) {
      onSuccess();
    } else {
      _errorMessage = "Invalid code";
    }
    notifyListeners();
  }

  Future<void> resendCode() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final random = Random();
    _dummyOtp = (1000 + random.nextInt(9000)).toString();

    _isLoading = false;
    _errorMessage = "New code sent: $_dummyOtp";
    notifyListeners();
  }
}
