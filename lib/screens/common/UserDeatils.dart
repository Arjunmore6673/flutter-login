import 'package:flutter/material.dart';

class UserDeatils extends StatelessWidget {
  final String mainTitle;
  final List<Widget> widgets;

  const UserDeatils({Key key, @required this.widgets, this.mainTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          mainTitle,
          style:
              TextStyle(color: Colors.purple, fontSize: 24, fontFamily: 'Mali'),
        ),
        Column(
          children: widgets,
        )
      ],
    );
  }
}
