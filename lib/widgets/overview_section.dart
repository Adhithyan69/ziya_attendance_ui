import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  Widget _buildCard(String label, String count, Color color,Color labelColor) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: labelColor)),
              const SizedBox(height: 4),
              Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard("Presence", "20", Colors.green,Colors.green),
        _buildCard("Absence", "03", Colors.red,Colors.red),
        _buildCard("Leaves", "02", Colors.orangeAccent,Colors.orangeAccent),
      ],
    );
  }
}
