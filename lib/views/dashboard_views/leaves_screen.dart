import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/widgets/leaves_screen_appBar.dart';
import '../../controller/dashboard_controllers/leaves_screen_controller.dart';
import '../../models/dashboard_models/leave_application_model.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: const LeavesScreenAppBar()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                child: Container(
                  width: 50,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [Icon(Icons.arrow_back_ios,size: 10,),Text("Back",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, color: appColors.primaryColor,)),],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10),
              child: Text("Apply for Leave",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, color: appColors.primaryColor,fontSize: 25)),
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
                    SizedBox(width: MediaQuery.of(context).size.width*1/2),
                    _buildLabel("To"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildDatePickerField("From Date", _fromDate,
                            (date) => setState(() => _fromDate = date))),
                    Row(
                      children: [
                        const Icon(Icons.arrow_left),
                        const Icon(Icons.arrow_right),
                      ],
                    ),
                    Expanded(
                        child: _buildDatePickerField("To Date", _toDate,
                            (date) => setState(() => _toDate = date))),
                  ],
                ),
              ],
            ),
            _buildLabel("Leave Type"),
            Row(
              children: [
                Expanded(child: _buildDropdown()),
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
                style: ElevatedButton.styleFrom(backgroundColor: appColors.buttonColor),
                child: const Text("Submit",style: TextStyle(color: appColors.selectedTextColor),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 2),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: appColors.primaryColor,)),
      );

  Widget _buildReadOnlyField(String value, IconData icon) => Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(icon,size: 18,),
            hintText: value,
            hintStyle: TextStyle(color: appColors.leaveScreenTextColor,),
            border: InputBorder.none,
          ),
        ),
      );

  Widget _buildDatePickerField(String hint, DateTime? selectedDate,
          Function(DateTime) onDatePicked) =>
      Card(
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
                prefixIcon: const Icon(Icons.calendar_month,color: appColors.leaveScreenTextColor,),
                hintText: selectedDate == null
                    ? hint
                    : selectedDate.toLocal().toString().split(' ')[0],
                border: InputBorder.none,
                hintStyle: TextStyle(color: appColors.leaveScreenTextColor,),
              ),
            ),
          ),
        ),
      );

  Widget _buildDropdown() => Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: DropdownButtonFormField<String>(
            items: const ["Sick Leave", "Casual Leave", "Earned Leave"]
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (val) => setState(() => _leaveType = val ?? ''),
            decoration: const InputDecoration(
              hintText: "Choose Type",
              isDense: true,
              hintStyle: TextStyle(color: appColors.leaveScreenTextColor,),
              labelStyle: TextStyle(color: appColors.leaveScreenTextColor,),
              border: InputBorder.none,
            ),
          ),
        ),
      );

  Widget _buildTextArea(TextEditingController controller) => Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: "Text area",
            hintStyle: TextStyle(color: appColors.leaveScreenTextColor,),
            border: InputBorder.none,
          ),
        ),
      );

  Widget _buildAttachmentField() => Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: TextField(
          readOnly: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.attach_file,color:appColors.leaveScreenTextColor,),
            hintText: "Attachment(Optional)",
            hintStyle: TextStyle(color: appColors.leaveScreenTextColor,),
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
          const SnackBar(content: Text("Please fill all required fields")));
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

    Provider.of<LeaveController>(context, listen: false)
        .submitLeave(application);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Leave Submitted")));
  }
}
