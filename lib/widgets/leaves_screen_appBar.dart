import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';

import '../constants/color_constants.dart';

class LeavesScreenAppBar extends StatelessWidget {
  const LeavesScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Image.asset('lib/assets/ziya_logo.jpg', width: 40, height: 40),
            const SizedBox(width: 10),
            const Expanded(
              child: Card(
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: appColors.buttonColor,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.notifications, size: 25, color: Colors.white),
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
              backgroundImage: NetworkImage('${TextConstants.profileImageUrl}'),
            ),
          ],
        ),
      ),
    );
  }
}
