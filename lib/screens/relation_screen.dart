import 'package:flutter/material.dart';

class RelationScreen extends StatefulWidget {
  RelationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RelationScreenState();
}

class RelationScreenState extends State<RelationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: circleAvtar(),
          flex: 1,
        ),
        Expanded(
          child: getListView(),
          flex: 1,
        ),
      ],
    );
  }

  Widget getListView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        SizedBox(width: 10),
        circleAvtar(),
        SizedBox(width: 10),
        circleAvtar(),
        SizedBox(width: 10),
        circleAvtar(),
        SizedBox(width: 10),
        circleAvtar(),
      ],
    );
  }

  Widget getContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: circleAvtar(),
              ),
              Expanded(child: personDetails()),
            ],
          )),
    );
  }

  Widget circleAvtar() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 90.0,
          backgroundImage: NetworkImage("https://i.stack.imgur.com/GsDIl.jpg"),
          backgroundColor: Colors.transparent,
        ),
        personDetails()
      ],
    );
  }

  Widget personDetails() {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // topRight: Radius.circular(40.0),
            ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "ARjun More",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Text(
              "Mama",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
              ),
            ),
            Text(
              "Village : Pune maha",
              style: TextStyle(
                fontSize: 12,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
