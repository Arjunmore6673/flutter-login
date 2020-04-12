import 'package:flutter/material.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';

class RelationScreen extends StatefulWidget {
  RelationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RelationScreenState();
}

class RelationScreenState extends State<RelationScreen> {
  String i =
      "https://i.pinimg.com/originals/a9/05/8b/a9058b3cfef548a75f36066c94c917ae.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircleAvatarCommon(i), personDetails()],
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            children: <Widget>[
              // ExpandableCardCommon(
              //   text: "Fuck",
              //   widgets: <Widget>[
              //     CircleAvatarCommon(i),
              //     CircleAvatarCommon(i),
              //     CircleAvatarCommon(i),
              //     CircleAvatarCommon(i),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget personDetails() {
    return Text("fudddd");
  }

  
}
