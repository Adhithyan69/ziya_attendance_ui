import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/otp_controller.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({
    super.key,
    required this.email,
    required Null Function() onVerified,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OtpController>();
    return Scaffold(
      backgroundColor: AppColors.otpBackgroundClr,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                TextConstants.verifyCode,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.otpTitleClr, // ✅
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "${TextConstants.emailInstruction}\n$email",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.otpSubtitleClr, // ✅
                ),
              ),
              SizedBox(height: 32.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                autoFocus: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8.r),
                  fieldHeight: 40.h,
                  fieldWidth: 50.w,
                  activeFillColor: AppColors.otpBackgroundClr,
                  inactiveFillColor: AppColors.otpBackgroundClr,
                  selectedFillColor: AppColors.otpBackgroundClr,
                  inactiveColor: AppColors.otpSubtitleClr,
                  selectedColor: AppColors.otpButtonClr,
                  activeColor: AppColors.otpButtonClr,
                ),
                enableActiveFill: true,
                onChanged: context.read<OtpController>().onOtpChange,
              ),
              if (controller.errorMessage != null)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    controller.errorMessage!,
                    style: TextStyle(
                      color: AppColors.otpErrorClr, // ✅
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: controller.isLoading
                    ? null
                    : context.read<OtpController>().resendCode,
                child: Text(
                  TextConstants.resendCode,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.otpErrorClr, // ✅
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 22.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () => context.read<OtpController>().verifyOtp(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(TextConstants.otpVerified),
                                backgroundColor: AppColors.otpButtonClr, // ✅
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ResetPasswordScreen(),
                              ),
                            );
                          }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.otpButtonClr, // ✅
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  child: controller.isLoading
                      ? SizedBox(
                          height: 20.w,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            color:
                                AppColors.otpBackgroundClr, // ✅ White spinner
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          TextConstants.continueText,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.otpBackgroundClr, // ✅
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
