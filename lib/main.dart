//import 'package:flutter/material.dart';
//import 'package:flutterapp/srcc/aap.dart';
//import 'package:flutterapp/srcc/screen/register_screen.dart';
//import 'package:flutterapp/srcc/screen/login_screen.dart';
//import 'package:flutterapp/srcc/screen/splash_screen.dart';
//
//
////void main() {
////  runApp(App());
////}
//
//void main() => runApp(new MaterialApp(
//    theme:
//    ThemeData(primaryColor: Colors.deepPurple,primarySwatch: Colors.deepPurple,
//        primaryColorDark: Colors.deepPurple),
//    debugShowCheckedModeBanner: false,
//    home: SplashScreen(),
//    routes: routes));
//
//var routes = <String, WidgetBuilder>{
//  "/RegistrationScreen": (BuildContext context) => RegisterScreen(),
//  "/LoginScreen": (BuildContext context) => LoginScreen(),
//
//};
import 'package:flutter/material.dart';
import 'package:flutterapp/screen/home_screen.dart';
import 'package:flutterapp/screen/login_screen.dart';
import 'package:flutterapp/screen/registration_screen.dart';
import 'package:flutterapp/screen/splash_screen.dart';



var routes = <String, WidgetBuilder>{
  "/RegistrationScreen": (BuildContext context) => RegistrationScreen(),
  "/LoginScreen": (BuildContext context) => LoginScreen(),
  "/HomeScreen": (BuildContext context) => HomeScreen(),
};

void main() => runApp(new MaterialApp(
    theme:
    ThemeData(primaryColor: Colors.deepPurple,primarySwatch: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));
