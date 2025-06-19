import '../models/dashboard_models/leave_dashboard_model.dart';

class LeaveService {
  fetchLeaveData<leaveData>() {
    return LeaveData(
      totalTaken: 16,
      remaining: 29,
      approvalRate: 92,
      pendingRequest: 1,
      teamOnLeave: 2,
      quarterlyLeave: [8, 6, 3, 2],
      totalDaysUsed: 20,
      upcomingStart: DateTime(2025, 4, 22),
      upcomingEnd: DateTime(2025, 4, 24),
      upcomingType: 'Annual Leave',
      upcomingStatus: 'Pending',
    );
  }
}
