import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/controller/auth_controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
      child: Consumer<ResetPasswordController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: AppColors.resetBackgroundClr,
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstants.resetTitle,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.resetTitleClr,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      TextConstants.resetSubtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.resetSubtitleClr,
                      ),
                    ),
                    SizedBox(height: 42.h),
                    Card(
                      color: AppColors.resetCardClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 1,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.key_outlined, size: 20.sp),
                          hintText: TextConstants.newPasswordHint,
                          hintStyle: TextStyle(fontSize: 12.sp),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 12.w,
                          ),
                        ),
                        onChanged: controller.onNewPasswordChanged,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Card(
                      color: AppColors.resetCardClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 1,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.key_outlined, size: 20.sp),
                          hintText: TextConstants.confirmPasswordHint,
                          hintStyle: TextStyle(fontSize: 12.sp),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 12.w,
                          ),
                        ),
                        onChanged: controller.onConfirmPasswordChanged,
                      ),
                    ),
                    if (controller.errorMessage != null) ...[
                      SizedBox(height: 10.h),
                      Text(
                        controller.errorMessage!,
                        style: TextStyle(
                          color: AppColors.resetErrorClr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.resetCancelBtnClr,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 4.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.cancel,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () {
                                  controller.resetPassword(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(TextConstants.resetSuccess),
                                        backgroundColor:
                                            AppColors.resetSuccessClr,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.resetButtonClr,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          child: controller.isLoading
                              ? SizedBox(
                                  width: 18.w,
                                  height: 18.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  TextConstants.resetPassword,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
