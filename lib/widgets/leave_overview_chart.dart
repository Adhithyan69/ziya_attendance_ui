import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';

class LeaveOverviewChart extends StatelessWidget {
  final List<int> quarterly;
  final int totalUsed;
  final int remaining;

  const LeaveOverviewChart({
    super.key,
    required this.quarterly,
    required this.totalUsed,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final max = quarterly.reduce((a, b) => a > b ? a : b).toDouble();

    return Card(
      elevation: 2,
      color: appColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Leave Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Your leave distribution for the current year", style: TextStyle(fontSize: 12)),
            const SizedBox(height: 16),

            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (index) {
                  final barHeight = (quarterly[index] / (max == 0 ? 1 : max)) * 30;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: barHeight,
                        width: 40,
                        decoration: BoxDecoration(
                          color: appColors.leavesOverviewContClr,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Q${index + 1}"),
                    ],
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle,color: appColors.leavesOverviewContClr,size: 12,),
                const SizedBox(width: 8,),
                Text('Leave days taken',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total days",style: TextStyle(fontSize: 11),),
                    Text("$totalUsed",style: TextStyle(fontSize: 11),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Remaining",style: TextStyle(fontSize: 11),),
                    Text("$remaining",style: TextStyle(fontSize: 11),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
