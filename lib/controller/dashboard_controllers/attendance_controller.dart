import 'package:flutter/material.dart';

import '../../models/dashboard_models/attendance_model.dart';

class AttendanceController extends ChangeNotifier {
  final List<Attendance> _records = [
    Attendance(date: DateTime(2025, 6, 6), status: 'Late'),
    Attendance(date: DateTime(2025, 6, 9), status: 'Present'),
    Attendance(date: DateTime(2025, 6, 10), status: 'Present'),
    Attendance(date: DateTime(2025, 6, 16), status: 'Present'),
    Attendance(date: DateTime(2025, 6, 17), status: 'Present'),
    Attendance(date: DateTime(2025, 6, 24), status: 'Absent'),
    Attendance(date: DateTime(2025, 6, 25), status: 'Leave'),
  ];

  List<Attendance> get records => _records;

  Map<DateTime, Color> getDateColors() {
    final Map<DateTime, Color> colors = {};
    for (var r in _records) {
      final date = DateTime(r.date.year, r.date.month, r.date.day);
      switch (r.status) {
        case 'Present':
          colors[date] = Colors.green.shade200;
          break;
        case 'Absent':
          colors[date] = Colors.red.shade300;
          break;
        case 'Leave':
          colors[date] = Colors.orange.shade300;
          break;
        case 'Late':
          colors[date] = Colors.blue.shade200;
          break;
      }
    }
    return colors;
  }

  Map<String, int> getSummary() {
    int present = 20, absent = 3, leave = 2, late = 6;
    return {
      'Present': present,
      'Absent': absent,
      'Leave': leave,
      'Late': late,
    };
  }
}
