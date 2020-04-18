import 'package:flutter/material.dart';
import 'package:flutterapp/screens/common/CenterInkText.dart';
import 'CardCommon.dart';

class ExpandableCardCommon extends StatelessWidget {
  final Widget child;
  final String text;
  final int length;
  ExpandableCardCommon(
      {@required this.child, @required this.text, this.length = 250});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return CardCommon(
      child: Theme(
        data: theme,
        child: ExpansionTile(
          title: CenterInkText(
            text: text,
          ),
          trailing: SizedBox(),
          children: <Widget>[
            Container(
              height: length > 0 ? 220 : 20,
              child: length > 0 ? child : Text("No data Present"),
            )
          ],
        ),
      ),
    );
  }
}
