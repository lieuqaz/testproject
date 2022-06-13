import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.maxLength,
      required this.maxLines,
      required this.fontStyle,
      required this.padding})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool maxLength;
  final int maxLines;
  final bool fontStyle;
  final bool padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ? const EdgeInsets.only(left: 20) : const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Enter value' : null,
            textAlign: TextAlign.start,
            controller: controller,
            maxLength: maxLength ? 500 : null,
            maxLines: maxLines,
            keyboardType: labelText == 'Start' || labelText == 'Target'
                ? TextInputType.number
                : null,
            inputFormatters: labelText == 'Start' || labelText == 'Target'
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(), borderRadius: BorderRadius.zero),
                hintText: hintText,
                hintStyle: fontStyle
                    ? const TextStyle(fontStyle: FontStyle.italic)
                    : null),
          ),
        ],
      ),
    );
  }
}
