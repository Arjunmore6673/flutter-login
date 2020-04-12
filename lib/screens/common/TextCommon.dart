import 'package:flutter/material.dart';

class TextCommon extends StatelessWidget {
  final String text;
  final double fontSize;
  TextCommon({@required this.text, this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }
}
