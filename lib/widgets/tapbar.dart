import 'package:flutter/material.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:ziya_attendance_ui/widgets/ongoing_pending_task_widget.dart';
import 'package:ziya_attendance_ui/widgets/simple_task_card.dart';
import 'package:ziya_attendance_ui/widgets/task_tracker_card.dart';
import 'package:ziya_attendance_ui/widgets/work_summary_grid.dart';

class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TaskCard> tasksTracker = [
    TaskCard(
      title: 'Responsive Design',
      dueDate: '18-06-2025',
      progress: 0.45,
      status: 'In Progress',
      priority: 'Medium',
      updates: 'Complete',
    ),
    TaskCard(
      title: 'UI/UX Design Implementation',
      dueDate: '18-06-2025',
      progress: 0.69,
      status: 'Completed',
      priority: 'High',
      updates: 'Update',
    ),
    TaskCard(
      title: 'Back-end Development',
      dueDate: '18-06-2025',
      progress: 0.75,
      status: 'In Progress',
      priority: 'High',
      updates: 'Start',
    ),
  ];
  final List<OngoingPendingTaskCard> ongoingPendingTask = [
    OngoingPendingTaskCard(
      title: "UI/UX Design Implementation",
      progress: 0.8,
      status: "Ongoing Task",
      startDate: "12-05-2025",
      dueDate: "12-06-2025",
      priority: "High",
      buttonText: "Make as Done",
    ),
    OngoingPendingTaskCard(
      title: "Responsive Design",
      progress: 0.45,
      status: "Pending Task",
      startDate: "12-05-2025",
      dueDate: "12-06-2025",
      priority: "Medium",
      buttonText: "Start task",
    ),
    OngoingPendingTaskCard(
      title: "Back-end Development",
      progress: 0.75,
      status: "Ongoing Task",
      startDate: "12-05-2025",
      dueDate: "12-06-2025",
      priority: "High",
      buttonText: "Make as Done",
    ),
    OngoingPendingTaskCard(
      title: "Server-side Logic",
      progress: 0.75,
      status: "Pending Task",
      startDate: "12-05-2025",
      dueDate: "12-06-2025",
      priority: "Low",
      buttonText: "Start task",
    ),
  ];
  final List<SimpleTaskCard> myTask = [
    SimpleTaskCard(
        title: 'UI/UX Design Implementation',
        description:
            'Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.'),
    SimpleTaskCard(
        title: 'Responsive Design',
        description:
            'Ensuring that the application adapts seamlessly to different screen sizes and devices.'),
    SimpleTaskCard(
        title: 'Back-end Development',
        description:
            'Creating and managing databases for efficient data storage, retrieval, and processing.'),
    SimpleTaskCard(
        title: 'Server-Side Logic',
        description:
            'Developing and maintaining the logic that runs on the server, handling user requests, processing data, and interacting with databases.')
  ];
  final List<Map<String, dynamic>> tabs = [
    {'icon': Icons.calendar_today, 'label': 'My Tasks'},
    {'icon': Icons.hourglass_bottom, 'label': 'Task Tracker'},
    {'icon': Icons.loop, 'label': 'Ongoing&Pending Tasks'},
    {'icon': Icons.wallet, 'label': 'Work Summary'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              final selected = _tabController.index == index;
              return GestureDetector(
                onTap: () {
                  _tabController.animateTo(index);
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                            )
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tabs[index]['icon'] as IconData,
                        color: selected ? Colors.white : Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tabs[index]['label'] as String,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Text("Sort by:", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Radio(value: true, groupValue: true, onChanged: null),
            Text("Deadline"),
            SizedBox(width: 20),
            Radio(value: true, groupValue: true, onChanged: null),
            Text("Project"),
            Spacer(),
            Icon(Icons.tune),
          ],
        ),
        AutoScaleTabBarView(
          controller: _tabController,
          children: [
            Column(children: myTask),
            Column(children: tasksTracker),
            Column(children: ongoingPendingTask),
            ProductivityDashboard(),
          ],
        ),
      ],
    );
  }
}
