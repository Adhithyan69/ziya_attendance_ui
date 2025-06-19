
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import '../../controller/dashboard_controllers/leaves_Request_controller.dart';
import '../../models/dashboard_models/leave_application_model.dart';

class LeavesRequestScreen extends StatefulWidget {
  const LeavesRequestScreen({super.key});

  @override
  State<LeavesRequestScreen> createState() => _LeavesRequestScreenState();
}

class _LeavesRequestScreenState extends State<LeavesRequestScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final String _employeeName = "Employee Name - auto-filled";
  final String _employeeId = "Employee ID - auto-filled";
  DateTime? _fromDate;
  DateTime? _toDate;
  String _leaveType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Apply for Leave",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appColors.primaryColor,
                  fontSize: 25,
                ),
              ),
            ),
            _buildLabel("Employee Name"),
            _buildReadOnlyField(_employeeName, Icons.perm_identity),
            _buildLabel("Employee ID"),
            _buildReadOnlyField(_employeeId, Icons.badge_outlined),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildLabel("From"),
                    SizedBox(width: MediaQuery.of(context).size.width * 1 / 2),
                    _buildLabel("To"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePickerField("From Date", _fromDate,
                              (date) => setState(() => _fromDate = date)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_right_alt_outlined),
                    const SizedBox(width: 4),
                    Expanded(
                      child: _buildDatePickerField("To Date", _toDate,
                              (date) => setState(() => _toDate = date)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: appColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            size: 15,
                            color: appColors.leaveScreenTextColor,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Leave Type',
                            style: TextStyle(
                                color: appColors.leaveScreenTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildCustomLeaveTypePicker()),
              ],
            ),
            _buildLabel("Reason"),
            _buildTextArea(_reasonController),
            _buildLabel("Attachment"),
            _buildAttachmentField(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: appColors.buttonColor),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: appColors.selectedTextColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 2),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: appColors.primaryColor,
      ),
    ),
  );

  Widget _buildReadOnlyField(String value, IconData icon) => Card(
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 18),
        hintText: value,
        hintStyle: const TextStyle(
          color: appColors.leaveScreenTextColor,
        ),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildDatePickerField(
      String hint, DateTime? selectedDate, Function(DateTime) onDatePicked) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) onDatePicked(picked);
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_month,
                  color: appColors.leaveScreenTextColor),
              hintText: selectedDate == null
                  ? hint
                  : selectedDate.toLocal().toString().split(' ')[0],
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: appColors.leaveScreenTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomLeaveTypePicker() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () => _showLeaveTypePopup(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _leaveType.isEmpty ? "Choose Type" : _leaveType,
                style: const TextStyle(
                  color: appColors.leaveScreenTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_drop_up,
                      color: appColors.leaveScreenTextColor),
                  const Icon(Icons.arrow_drop_down,
                      color: appColors.leaveScreenTextColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaveTypePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              "Casual Leave",
              "Sick Leave",
              "Work From Home",
              "Earned Leave",
            ].map(
                  (type) => ListTile(
                title: Text(type),
                onTap: () {
                  setState(() => _leaveType = type);
                  Navigator.pop(context);
                },
              ),
            )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildTextArea(TextEditingController controller) => Card(
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: TextField(
      controller: controller,
      maxLines: 4,
      decoration: const InputDecoration(
        hintText: "Text area",
        hintStyle: TextStyle(
          color: appColors.leaveScreenTextColor,
        ),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildAttachmentField() => Card(
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: const TextField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon:
        Icon(Icons.attach_file, color: appColors.leaveScreenTextColor),
        hintText: "Attachment(Optional)",
        hintStyle: TextStyle(color: appColors.leaveScreenTextColor),
        border: InputBorder.none,
      ),
    ),
  );

  void _submit() {
    if (_fromDate == null ||
        _toDate == null ||
        _leaveType.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final application = LeaveApplication(
      employeeName: _employeeName,
      employeeId: _employeeId,
      fromDate: _fromDate!,
      toDate: _toDate!,
      leaveType: _leaveType,
      reason: _reasonController.text,
    );

    Provider.of<LeaveRequestController>(context, listen: false)
        .submitLeave(application);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Leave Submitted")));
  }
}
