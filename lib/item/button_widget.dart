import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.tittle})
      : super(key: key);
  final VoidCallback onTap;
  final Color color;
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.black))),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) => color)),
          onPressed: onTap,
          child: Text(
            tittle,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
