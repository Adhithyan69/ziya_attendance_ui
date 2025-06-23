import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';

class LeavesScreenAppBar extends StatelessWidget {
  const LeavesScreenAppBar({super.key});

  void _showSearchDropdown(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: TextConstants.search,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      TextConstants.mayDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2 - 50,
                    ),
                    Card(
                      color: Colors.lightGreen.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstants.searchHistory,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(TextConstants.sickLeave),
                        SizedBox(height: 8),
                        Text(TextConstants.sampleSearchDate),
                        SizedBox(height: 8),
                        Text(TextConstants.casualLeave),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Image.asset('lib/assets/ziya_logo.jpg', width: 40, height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _showSearchDropdown(context),
                child: const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          TextConstants.search,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: appColors.buttonColor,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.notifications,
                      size: 25, color: Colors.white),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage("${TextConstants.profileImageUrl}"),
            ),
          ],
        ),
      ),
    );
  }
}
