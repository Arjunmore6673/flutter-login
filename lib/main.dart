import 'package:flutter/material.dart';
import 'package:flutterapp/srcc/aap.dart';
import 'package:flutterapp/srcc/screen/register_screen.dart';
import 'package:flutterapp/srcc/screen/login_screen.dart';
import 'package:flutterapp/srcc/screen/splash_screen.dart';


//void main() {
//  runApp(App());
//}

void main() => runApp(new MaterialApp(
    theme:
    ThemeData(primaryColor: Colors.deepPurple,primarySwatch: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));

var routes = <String, WidgetBuilder>{
  "/RegistrationScreen": (BuildContext context) => RegisterScreen(),
  "/LoginScreen": (BuildContext context) => LoginScreen(),

};
