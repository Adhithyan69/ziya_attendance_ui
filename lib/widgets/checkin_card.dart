import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInCard extends StatefulWidget {
  const CheckInCard({super.key});

  @override
  State<CheckInCard> createState() => _CheckInCardState();
}

class _CheckInCardState extends State<CheckInCard> {
  bool isCheckedIn = false;
  String? checkInTime;
  String? checkOutTime;

  void handleCheckIn() {
    setState(() {
      isCheckedIn = true;
      checkInTime = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  void handleCheckOut() {
    setState(() {
      isCheckedIn = false;
      checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue.shade50.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCheckedIn
                  ? "You are checked in at $checkInTime"
                  : "You haven't Checked-in yet",
              style: TextStyle(color: isCheckedIn ? Colors.green : Colors.red),
            ),
            if (checkOutTime != null)
              Text(
                "Last Checked out at $checkOutTime",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isCheckedIn ? null : handleCheckIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCheckedIn ? Colors.grey[300] :Colors.blue ,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.input,size: 20,color: Colors.white,),
                        Text("Check In",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isCheckedIn ? handleCheckOut : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCheckedIn ? Colors.blue : Colors.grey[300],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.output,size: 20,color: Colors.white,),
                        Text("Check Out",style: TextStyle(color: Colors.white,)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
