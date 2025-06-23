import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/widgets/attendanceCalendar.dart';
import 'package:ziya_attendance_ui/widgets/dottedDivider.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';
import '../../controller/dashboard_controllers/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AttendanceController>(context);
    final dateColors = controller.getDateColors();
    final focusedDayNotifier = ValueNotifier<DateTime>(DateTime.now());

    return Scaffold(
      backgroundColor: appColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: appColors.secondaryColor,
        title: const Text('Attendance Calendar'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AttendanceCalendar(
              dateColors: dateColors,
              focusedDayNotifier: focusedDayNotifier,
            ),
            const SizedBox(height: 12),
            Card(
              color: appColors.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    const Text(
                      'Total Days: 31',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        _buildOverviewCard(
                            TextConstants.presence,
                            TextConstants.presenceLength,
                            appColors.presenceClr),
                        _buildOverviewCard(
                            TextConstants.absence,
                            TextConstants.absenceLength,
                            appColors.absenceClr),
                        _buildOverviewCard(
                            TextConstants.leaves,
                            TextConstants.leavesLength,
                            appColors.leavesClr),
                        _buildOverviewCard(
                            TextConstants.late,
                            TextConstants.lateLength,
                            appColors.lateClr),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildPieChart(controller.getSummary()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'June 18, 2025',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Status', style: TextStyle(fontSize: 15)),
                Chip(
                  label: const Text('Present',
                      style: TextStyle(color: Colors.green)),
                  color: WidgetStatePropertyAll(Colors.green.shade100),
                  side: BorderSide.none,
                ),
              ],
            ),
            dottedDivider(66),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildCheckInfo(
                    Icons.alarm_on, "Check-in", "09:30 AM", Colors.green),
                const Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                        child: Divider(thickness: 1.2,)),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ],
                ),
                const Spacer(),
                _buildCheckInfo(
                    Icons.alarm_off, "Check-out", "06:00 PM", Colors.green),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTagBox(
                    "Work Mode", "Office", Colors.blue.shade100, Colors.blue.shade800),
                const Spacer(),
                _buildTagBox("Verification", "Selfie", Colors.orange.shade100,
                    Colors.orange),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoBox(
              icon: Icons.person_pin_circle_outlined,
              label: "Location",
              value: "Lat: 13.05, Long: 80.24",
              iconColor: Colors.red,
            ),
            const SizedBox(height: 8),
            _buildInfoBox(
              icon: Icons.text_snippet_outlined,
              label: "Notes",
              value: "Worked On UI Bug Fixing",
              iconColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
      String label, String count, Color color) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: color, fontSize: 11)),
              const SizedBox(height: 4),
              Text(count,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckInfo(
      IconData icon, String label, String time, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(time, style: TextStyle(color: color)),
          ],
        )
      ],
    );
  }

  Widget _buildTagBox(
      String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: Colors.blue, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              )),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: bgColor,
            ),
            child: Text(value,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Card(
      color: appColors.secondaryColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> summary) {
    final colors = {
      'Present': Colors.green,
      'Absent': Colors.red,
      'Leave': Colors.orange,
      'Late': Colors.blue,
    };

    return Container(
      height: 200,
      width: double.infinity,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: summary.entries.map((entry) {
            final label = "${entry.value.toString().padLeft(2, '0')} \nDays";
            return PieChartSectionData(
              value: entry.value.toDouble(),
              color: colors[entry.key],
              title: label,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              ),
              radius: 60,
            );
          }).toList(),
        ),
      ),
    );
  }
}
