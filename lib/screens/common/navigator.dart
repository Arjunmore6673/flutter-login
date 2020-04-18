import 'package:flutter/material.dart';
import 'package:flutterapp/screens/register_screen.dart';

class Nevigator {
 static navigateRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
}
