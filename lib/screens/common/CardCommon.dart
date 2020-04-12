import 'package:flutter/material.dart';

class CardCommon extends StatelessWidget {
  final double elevation;
  final Widget child;

  const CardCommon({Key key, @required this.child, this.elevation = 3})
      : assert(elevation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        margin: EdgeInsets.all(10),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(40.0),
        //       ),
        // ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: child,
        ),
      ),
    );
  }
}
