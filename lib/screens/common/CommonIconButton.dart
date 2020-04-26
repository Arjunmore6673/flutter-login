import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  final Function onTap;
  final Color color;

  const CommonIconButton(
      {Key key,
      this.icon,
      @required this.buttonText,
      this.color = Colors.white,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              color: color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  icon == null
                      ? SizedBox()
                      : Icon(
                          icon,
                          color: Colors.orange,
                        ),
                  SizedBox(width: 9),
                  Text(buttonText,
                      style: TextStyle(color: Colors.blue, fontSize: 18)),
                ],
              ),
              onPressed: onTap),
        ],
      ),
    );
  }
}
