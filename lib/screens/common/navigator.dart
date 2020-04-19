import 'package:flutter/material.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/login_page.dart';
import 'package:flutterapp/screens/navigation_home_screen.dart';
import 'package:flutterapp/screens/register_screen.dart';

class Nevigator {
  static navigateRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  static navigateNavigationHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
    );
  }
  static navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(userRepository: UserRepository())),
    );
  }
}
