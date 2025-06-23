import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/widgets/home_appBar_widget.dart';
import '../widgets/checkin_card.dart';
import '../widgets/overview_section.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/tapbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: const HomeAppBarWidget(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('${TextConstants.wishes} ${TextConstants.userName}"',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 20),
                  const CheckInCard(),
                  const SizedBox(height: 10),
                  const Text('${TextConstants.overView}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  const OverviewSection(),
                  const SizedBox(height: 10),
                  TabBarSection(),
                  const SizedBox(height: 10),
                  const Text('${TextConstants.dashboard}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  const DashboardGridView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
