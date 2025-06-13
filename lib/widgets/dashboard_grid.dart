import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<DashboardItem> items = [
      DashboardItem(
          label: "Attendance", icon: Icons.calendar_month, color: Colors.green),
      DashboardItem(
          label: "Leaves", icon: Icons.logout, color: Colors.orange),
      DashboardItem(
          label: "Leave Status",
          icon: Icons.pie_chart,
          color: Colors.purple),
      DashboardItem(
          label: "Holiday List", icon: Icons.checklist_sharp, color: Colors.blue),
      DashboardItem(label: "Payslip", icon: Icons.my_library_books, color: Colors.teal),
      DashboardItem(
          label: "Reports", icon: Icons.show_chart, color: Colors.redAccent),
    ];
    return Container(
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Material(
            color: Colors.white,
            elevation: 2,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8,),
                  CircleAvatar(
                    backgroundColor: item.color.withOpacity(0.2),
                    radius: 28,
                    child: Icon(item.icon, color: item.color),
                  ),
                  const SizedBox(height: 8),
                  Text(item.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
