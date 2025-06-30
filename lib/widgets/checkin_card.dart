import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';

import '../constants/color_constants.dart';
import '../controller/checkin_card_controller.dart';
import '../views/face_verification.screen.dart';
import '../views/qr_verification_screen.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  void openCheckInDialog(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                TextConstants.selectPunchInType,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                TextConstants.punchInDialog,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.checkIn(onsite: true);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QrVerificationScreen(
                              time: provider.checkInTime!,
                              checkedIn: true,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        TextConstants.onSite,
                        style: TextStyle(color: AppColors.unSelectedTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.checkIn(onsite: false);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FaceVerificationScreen(
                              time: provider.checkInTime!,
                              checkedIn: true,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        TextConstants.wfh,
                        style: TextStyle(color: AppColors.selectedTextColor),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void openCheckOutDialog(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const Icon(Icons.warning_amber_rounded,
                  size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                TextConstants.doYouReallyWantToCheckout,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        TextConstants.updateTask,
                        style: TextStyle(color: AppColors.unSelectedTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.checkOut();
                        Navigator.pop(context);
                        final isOnSite = provider.isOnsite;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => isOnSite
                                ? QrVerificationScreen(
                                    time: provider.checkInTime!,
                                    checkedIn: false,
                                  )
                                : FaceVerificationScreen(
                                    time: provider.checkInTime!,
                                    checkedIn: false,
                                  ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        TextConstants.punchOut,
                        style: TextStyle(color: AppColors.selectedTextColor),
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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    return Card(
      color: Colors.blue.shade50.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.isCheckedIn
                  ? "${TextConstants.checkedInAt} ${provider.checkInTime}"
                  : TextConstants.haventCheckedText,
              style: TextStyle(
                  color: provider.isCheckedIn ? Colors.green : Colors.red),
            ),
            if (provider.checkOutTime != null)
              Text("${TextConstants.checkedOutText}${provider.checkOutTime}"),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: provider.isCheckedIn
                          ? AppColors.secondaryButton
                          : AppColors.buttonColor,
                    ),
                    onPressed: provider.isCheckedIn
                        ? null
                        : () => openCheckInDialog(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.input,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          TextConstants.punchIn,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: provider.isCheckedIn
                        ? () => openCheckOutDialog(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: provider.isCheckedIn
                          ? AppColors.buttonColor
                          : AppColors.secondaryButton,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.output,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(TextConstants.punchOut,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
