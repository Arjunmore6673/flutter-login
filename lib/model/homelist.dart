import 'package:flutter/widgets.dart';
import 'package:flutterapp/screens/register_screen.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: RegisterScreen(),
    ),
//    HomeList(
//      imagePath: 'assets/fitness_app/fitness_app.png',
//      navigateScreen: FitnessAppHomeScreen(),
//    ),
//    HomeList(
//      imagePath: 'assets/design_course/design_course.png',
//      navigateScreen: DesignCourseHomeScreen(),
//    ),
  ];
}
