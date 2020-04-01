import 'package:flutter/material.dart';
import 'package:flutterapp/src/screen/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "log me in",
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
