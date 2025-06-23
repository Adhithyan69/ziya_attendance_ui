import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/views/punch_in_out_success_screen.dart';

class QrVerificationScreen extends StatefulWidget {
  const QrVerificationScreen({super.key, required this.time, required this.checkedIn});
  final String time;
  final bool checkedIn;
  @override
  State<QrVerificationScreen> createState() => _QrVerificationScreenState();
}

class _QrVerificationScreenState extends State<QrVerificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60,),
                const Text(
                  TextConstants.qrVerification,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: appColors.unSelectedTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  TextConstants.pleaseScanYourQRCode,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 92),

                Center(
                  child: Container(
                    padding: EdgeInsets.all(32),
                    height: 220,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Lottie.asset(
                      TextConstants.qRAnimation,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                Center(
                  child: SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PunchInOutSuccessScreen(time: widget.time, checkedIn: widget.checkedIn,)));
                      },
                      child: const Text(
                        TextConstants.scanQR,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
