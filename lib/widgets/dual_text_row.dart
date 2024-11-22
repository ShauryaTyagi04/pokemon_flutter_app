import 'package:flutter/material.dart';

class DualTextRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? colour;

  const DualTextRow({
    super.key,
    required this.title,
    required this.subTitle,
    this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colour != null ? colour : Colors.green,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
