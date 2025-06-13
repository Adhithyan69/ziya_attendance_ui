
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String dueDate;
  final double progress;
  final String status;
  final String priority;
  final String updates;

  const TaskCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.priority,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              Text("Due Date: $dueDate", style: const TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            const Text('Status:  ', style: TextStyle(fontSize: 12)),
            _statusDot("Not Started"),
            _statusDot("In Progress"),
            _statusDot("Completed"),
            _statusDot("Overdue"),
          ]),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Progress:', style: TextStyle(fontSize: 12)),

              CircularPercentIndicator(
                radius: 22.0,
                lineWidth: 4.0,
                percent: progress,
                center: Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 10)),
                progressColor: Colors.green,
              ),

              Row(
                children: const [
                  Icon(Icons.timer, size: 18, color: Colors.orange),
                  SizedBox(width: 4),
                  Text("2 days\nremaining",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 10)),
                ],
              ),

              Row(
                children: const [
                  Icon(Icons.edit_note, size: 18),
                  SizedBox(width: 4),
                  Text("Assigned By\n(optional)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10)),
                ],
              )
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Text("Priority:", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              _priorityText("Low"),
              _priorityText("Medium"),
              _priorityText("High"),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionItem("Start"),
              _actionItem("Update"),
              _actionItem("Complete"),
            ],
          ),

          const SizedBox(height: 15),

          dottedDivider(),
        ],
      ),
    );
  }

  Widget _statusDot(String label) {
    bool selected = label == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: selected ? Colors.green : Colors.grey.shade400,
          ),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? Colors.black : Colors.grey,
              )),
        ],
      ),
    );
  }

  Widget _priorityText(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: priority == label ? Colors.teal : Colors.black,
        ),
      ),
    );
  }

  Widget _actionItem(String label) {
    bool selected = updates == label;
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.circle,
              size: 12, color: selected ? Colors.green : Colors.black),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

Widget dottedDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      60,
          (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Container(
          width: 2,
          height: 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
