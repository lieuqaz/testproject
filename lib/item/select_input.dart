import 'package:flutter/material.dart';

class SelectInputWidget extends StatefulWidget {
  const SelectInputWidget({
    Key? key,
    required this.listobject,
    required this.label,
  }) : super(key: key);
  final List<String> listobject;
  final String label;
  @override
  State<SelectInputWidget> createState() => _SelectInputWidgetState();
}

class _SelectInputWidgetState extends State<SelectInputWidget> {
  String type = '';
  @override
  void initState() {
    type = widget.listobject[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Column(
        children: [
          Align(alignment: Alignment.bottomLeft, child: Text(widget.label)),
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.zero, border: Border.all(width: 1)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: type,
                items: widget.listobject.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    type = newValue!;
                  });
               
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
