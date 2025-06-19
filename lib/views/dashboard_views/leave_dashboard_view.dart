import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/dashboard_controllers/leave_dashboard_controller.dart';
import '../../widgets/leave_overview_chart.dart';
import '../../widgets/leave_status_card.dart';
import '../../widgets/upcoming_leave_card.dart';

class LeaveDashboardScreen extends StatelessWidget {
  const LeaveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveDashboardController()..loadLeaveData(),
      child: Consumer<LeaveDashboardController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.leaveData!;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LeaveStatCard(
                            widget: Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent.shade100,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                 
                                ),
                                Container(
                                  height: 5,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue
                                  ),
                                ),
                              ],
                            ),
                            title: "Total Leave Taken",
                            value: "${data.totalTaken} days",
                            subtitle:
                                "${data.remaining} days remaining this year",
                            icon: Icons.article_outlined,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: LeaveStatCard(
                            widget: SizedBox.shrink(),
                            title: "Approval Rate",
                            value: "${data.approvalRate}%",
                            subtitle:
                                "${data.remaining} days remaining this year",
                            icon: Icons.radar,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: LeaveStatCard(
                            widget: SizedBox.shrink(),
                            title: "Pending Request",
                            value: "${data.pendingRequest}",
                            subtitle:
                                "${data.remaining} days remaining this year",
                            icon: Icons.hourglass_empty_sharp
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: LeaveStatCard(
                            widget: SizedBox.shrink(),
                            title: "Team Member \non Leave",
                            value: "${data.teamOnLeave}",
                            subtitle:
                                "${data.remaining} days remaining this year",
                            icon: Icons.group_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LeaveOverviewChart(
                      quarterly: data.quarterlyLeave,
                      totalUsed: data.totalDaysUsed,
                      remaining: data.remaining,
                    ),
                    const SizedBox(height: 10),
                    UpcomingLeaveCard(
                      type: data.upcomingType,
                      start: data.upcomingStart!,
                      end: data.upcomingEnd!,
                      status: data.upcomingStatus,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
