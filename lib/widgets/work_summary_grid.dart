import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/models/prodectivity_dashB_item.dart';

class ProductivityDashboard extends StatelessWidget {
  const ProductivityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProdectivityDashbItem> summaryItem = [
      ProdectivityDashbItem(
        title: 'Total Working \nDays',
        icon: Icons.calendar_month,
        subtitle: "20",
      ),
      ProdectivityDashbItem(
        title: 'Total Hours \nworked',
        icon: Icons.access_time,
        subtitle: '160 hours',
      ),
      ProdectivityDashbItem(
        title: 'Average Daily \nHours',
        icon: Icons.av_timer,
        subtitle: '8.0 hours',
      ),
      ProdectivityDashbItem(
        title: 'Productivity \nIndicator',
        icon: Icons.bar_chart,
        subtitle: '80%',
      ),
      ProdectivityDashbItem(
        title: 'Projects Involved',
        icon: Icons.person,
        subtitle: 'Revenue\nDashboard',
      ),
      ProdectivityDashbItem(
        title: 'Leave Taken',
        icon: Icons.library_books_outlined,
        subtitle: '2 days',
      ),
    ];

    return Card(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: summaryItem.map((item) {
            return Material(
              elevation: 2,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.icon,
                          color: appColors.dashboardGridItemColor, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: const TextStyle(
                                  fontSize: 9.2,
                                  color: appColors.dashboardGridTextColor,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            const SizedBox(height: 6),
                            Text(item.subtitle,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: appColors.dashboardGridTextColor,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
