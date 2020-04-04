import 'package:flutter/material.dart';
import 'ui/movie_list.dart';
import 'package:flutterapp/src/screen/register_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "log me in",
      home: Scaffold(
        body: RegisterScreen(),
      ),
    );
  }
}
//class App extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      theme: ThemeData.dark(),
//      home: Scaffold(
//        body: MovieList(),
//      ),
//    );
//  }
//}