import 'package:flutter/material.dart';

class CenterInkText extends StatelessWidget {
  final text;
  final Widget child;
  final Function onClick;
  CenterInkText({@required this.text, this.child, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onClick,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Ink free',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
