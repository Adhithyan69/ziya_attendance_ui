import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/controller/dashboard_controllers/holiday_controller.dart';
import 'package:ziya_attendance_ui/widgets/holidayCalendar.dart';
import 'package:ziya_attendance_ui/widgets/leave_status_card.dart';
import '../../widgets/leaves_screen_appBar.dart';

class HolidayListScreen extends StatelessWidget {
  const HolidayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HolidayController>(context);
    final dateColors = controller.getDateColors();

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: LeavesScreenAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: LeaveStatusCard(
                      subValue: '',
                      title: TextConstants.totalHolidays,
                      value: "18 days",
                      subtitle: TextConstants.inAYear,
                      icon: Icons.calendar_month,
                      widget: Stack(
                        children: [
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.progressTrackColor, // Updated
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppColors.lateClr, // Updated
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: LeaveStatusCard(
                      subValue: TextConstants.bakridNote,
                      title: TextConstants.upcomingHolidays,
                      value: "4",
                      subtitle: TextConstants.remainingThisMonth,
                      icon: Icons.calendar_month,
                      widget: const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildColorCode(AppColors.publicClr, TextConstants.public),
                  const SizedBox(width: 10),
                  _buildColorCode(AppColors.optionalClr, TextConstants.optional),
                  const SizedBox(width: 10),
                  _buildColorCode(AppColors.companyClr, TextConstants.company),
                ],
              ),
              const SizedBox(height: 30),
              HolidayCalendar(dateColors: dateColors),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: AppColors.greyBorder, blurRadius: 4), // grey.shade300 replaced
                  ],
                ),
                child: Table(
                  border: TableBorder.all(color: AppColors.greyBorder), // grey.shade300 replaced
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2.5),
                    2: FlexColumnWidth(2.5),
                    3: FlexColumnWidth(2.5),
                  },
                  children: [
                    _buildRow(TextConstants.dateHeader, [
                      TextConstants.date1,
                      TextConstants.date2,
                      TextConstants.date3
                    ]),
                    _buildRow(TextConstants.dayHeader, [
                      TextConstants.day1,
                      TextConstants.day2,
                      TextConstants.day3
                    ]),
                    _buildRow(TextConstants.holidayName, [
                      TextConstants.holiday1,
                      TextConstants.holiday2,
                      TextConstants.holiday3
                    ]),
                    _buildRow(TextConstants.type, [
                      TextConstants.type1,
                      TextConstants.type2,
                      TextConstants.type3
                    ]),
                    _buildRow(TextConstants.note, [
                      TextConstants.note1,
                      TextConstants.note2,
                      TextConstants.note3
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorCode(Color color, String value) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(value, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  TableRow _buildRow(String header, List<String> values) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            header,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
        ),
        for (final value in values)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
      ],
    );
  }
}
