
import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => new _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("Home"),
        ),
      ),
    );
  }
}


