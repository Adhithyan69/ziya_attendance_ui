import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/color_constants.dart';

class UpcomingLeaveCard extends StatelessWidget {
  final String type;
  final DateTime start;
  final DateTime end;
  final String status;

  const UpcomingLeaveCard({
    super.key,
    required this.type,
    required this.start,
    required this.end,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final days = end.difference(start).inDays + 1;
    final formattedStart = DateFormat.yMMMd().format(start);
    final formattedEnd = DateFormat.yMMMd().format(end);

    return Card(
      color: appColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upcoming Leave",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Your scheduled time off"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$type\n$formattedStart to $formattedEnd ($days days)",
                  style: const TextStyle(fontSize: 12),
                ),
                Chip(
                  label: Text(status),
                  backgroundColor: appColors.secondaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.yellow[100],
              child: Row(
                children: [
                   Icon(Icons.error_outline, color: appColors.warningClr),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pending Approval",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: appColors.warningClr),
                        ),
                        Text(
                          "Your leave request is awaiting manager approval.",
                          style: TextStyle(
                              fontSize: 14, color: Colors.brown),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
