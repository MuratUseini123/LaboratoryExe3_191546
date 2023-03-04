import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './course.dart';

class NewCourseTermin extends StatefulWidget {
  final Function addItem;
  final int termin_id;
  NewCourseTermin(this.addItem, this.termin_id);
  @override
  State<StatefulWidget> createState() => _NewCourseTerminState();
}
class _NewCourseTerminState extends State<NewCourseTermin> {
  final _CourseNameController = TextEditingController();
  final _TerminDateController = TextEditingController();
  final _TerminTimeController = TextEditingController();
  void _submitData() {
    if (_CourseNameController.text.isEmpty) {
      return;
    }
    final enteredName = _CourseNameController.text;
    final enteredTermin = "${_TerminDateController.text} ${_TerminTimeController.text}";
    final newItem = Course(widget.termin_id,enteredName, DateTime.parse(enteredTermin));
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _CourseNameController,
            decoration: const InputDecoration(labelText: "Enter Course Name"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _TerminDateController,
            decoration: const InputDecoration(labelText: "Enter termin"),
            onSubmitted: (_) => _submitData(),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000),
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _TerminDateController.text =
                      formattedDate; 
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          TextField(
            controller: _TerminTimeController,
            decoration: const InputDecoration(labelText: "Enter termin time"),
            onSubmitted: (_) => _submitData(),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (pickedTime != null) {
                print(pickedTime.format(context));
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());
                print(parsedTime); 
                String formattedTime =
                    DateFormat('HH:mm:ss').format(parsedTime);
                setState(() {
                  _TerminTimeController.text =
                      formattedTime;
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          ElevatedButton(onPressed: _submitData, child: const Text("Create"))
        ],
      ),
    );
  }
}
