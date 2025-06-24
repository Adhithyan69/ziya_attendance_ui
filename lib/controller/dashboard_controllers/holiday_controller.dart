
 import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/models/dashboard_models/holiday_model.dart';

import '../../constants/color_constants.dart';

class HolidayController extends ChangeNotifier{

  final List<HolidayModel> _records=[
    HolidayModel(date: DateTime(2025,6,3), status: TextConstants.public),
    HolidayModel(date: DateTime(2025,6,12), status: TextConstants.public),
    HolidayModel(date: DateTime(2025,6,20), status: TextConstants.optional),
    HolidayModel(date: DateTime(2025,6,16), status: TextConstants.company),
    HolidayModel(date: DateTime(2025,6,17), status: TextConstants.company),
    HolidayModel(date: DateTime(2025,6,25), status: TextConstants.company),
  ];

  List<HolidayModel> get records=>_records;

  Map<DateTime, Color> getDateColors() {
    final Map<DateTime, Color> colors = {};
    for (var r in _records) {
      final date = DateTime(r.date.year, r.date.month, r.date.day);
      switch (r.status) {
        case '${TextConstants.public}':
          colors[date] = AppColors.publicClr;
          break;
        case '${TextConstants.optional}':
          colors[date] =AppColors.optionalClr;
          break;
        case '${TextConstants.company}':
          colors[date] = AppColors.companyClr;
          break;
      }
    }
    return colors;
  }



}