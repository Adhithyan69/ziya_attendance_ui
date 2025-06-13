import 'package:flutter/material.dart';

class ProductivityDashboard extends StatelessWidget {
  const ProductivityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> summary = [
      {
        'title': 'Total Working \nDays',
        'value': '20',
        'icon': Icons.calendar_month
      },
      {
        'title': 'Total Hours \nworked',
        'value': '160 hours',
        'icon': Icons.access_time
      },
      {
        'title': 'Average Daily \nHours',
        'value': '8.0 hours',
        'icon': Icons.av_timer
      },
      {
        'title': 'Productivity \nIndicator',
        'value': '80%',
        'icon': Icons.bar_chart
      },
      {
        'title': 'Projects Involved',
        'value': 'Revenue\nDashboard',
        'icon': Icons.person
      },
      {
        'title': 'Leave Taken',
        'value': '2 days',
        'icon': Icons.library_books_outlined
      },
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
          children: summary
              .map((item) => Material(
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
                            Icon(item['icon'], color: Colors.teal, size: 30),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title']!,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis)),
                                const SizedBox(height: 6),
                                Text(item['value']!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
