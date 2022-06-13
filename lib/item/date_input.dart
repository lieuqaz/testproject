import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputWidget extends StatefulWidget {
  const DateInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DateInputWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  DateFormat month = DateFormat.MMMM('en_US');
  String date = DateTime.now().day.toString() +
      "-" +
      DateFormat.MMMM('en_US').format(DateTime.now()) +
      "-" +
      DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text('Due date'),
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1), borderRadius: BorderRadius.zero),
            child: InkWell(
              onTap: () async {
                final newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 10));
                if (newDate == null) return;
                setState(() {
                  date = newDate.day.toString() +
                      "-" +
                      month.format(newDate) +
                      "-" +
                      newDate.year.toString();
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_view_day_rounded),
                  Text(date)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
