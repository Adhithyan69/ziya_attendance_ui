import 'package:flutter/material.dart';

import '../../models/dashboard_models/leave_dashboard_model.dart';
import '../../services/leave_service.dart';


class LeaveDashboardController extends ChangeNotifier {
  final LeaveService _leaveService = LeaveService();

  LeaveData? _leaveData;
  LeaveData? get leaveData => _leaveData;

  bool _loading = true;
  bool get isLoading => _loading;

  Future<void> loadLeaveData() async {
    _loading = true;
    notifyListeners();

    _leaveData = await _leaveService.fetchLeaveData();

    _loading = false;
    notifyListeners();
  }
}
