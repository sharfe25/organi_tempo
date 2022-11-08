import 'package:flutter/material.dart';

class DatePickerItem extends StatelessWidget {
  DatePickerItem({required this.children});

  final List<Widget> children;
  final BorderSide whiteBorderSide = BorderSide(
    color: Color.fromARGB(255, 255, 255, 255),
    width: 1.0,
  );
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
            top: whiteBorderSide,
            bottom: whiteBorderSide,
            left: whiteBorderSide,
            right: whiteBorderSide),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}