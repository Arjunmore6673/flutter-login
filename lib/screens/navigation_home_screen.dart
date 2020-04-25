import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutterapp/app_theme.dart';
import 'package:flutterapp/custom_drawer/drawer_user_controller.dart';
import 'package:flutterapp/custom_drawer/home_drawer.dart';
import 'package:flutterapp/screens/contact_list.dart';
import 'package:flutterapp/screens/feedback_screen.dart';
import 'package:flutterapp/screens/help_screen.dart';
import 'package:flutterapp/screens/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/relation_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  AnimationController sliderAnimationController;

  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;

  List<Widget> screens;

  @override
  void initState() {
    super.initState();
    RelationScreen relationScreen = new RelationScreen();
    screens = [
      relationScreen,
      ContactListPage(),
      HelpScreen(),
      FeedbackScreen(),
      InviteFriend()
    ];
    drawerIndex = DrawerIndex.HOME;
    screenView = relationScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              animationController: (AnimationController animationController) {
                sliderAnimationController = animationController;
              },
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: currentPage == 0
                  ? screenView
                  : IndexedStack(
                      index: currentPage,
                      children: screens,
                    )),
          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(
                iconData: Icons.home,
                title: "Home",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(0);
                },
              ),
              TabData(
                iconData: Icons.contacts,
                title: "Contacts",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(1);
                },
              )
            ],
            initialSelection: 0,
            key: bottomNavigationKey,
            onTabChangedListener: (position) {
              setState(() {
                currentPage = position;
              });
            },
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          currentPage = 0;
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          // screenView = HelpScreen();
          currentPage = 2;
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
          currentPage = 3;
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          // screenView = InviteFriend();
          currentPage = 4;
        });
      } else {
        //do in your way......
      }
    }
  }

  // _getPage(int page) {
  //   switch (page) {
  //     case 0:
  //       screenView = RelationScreen();
  //       return RelationScreen();
  //     case 1:
  //       screenView = ContactListPage();
  //       return ContactListPage();
  //     default:
  //       return ContactListPage();
  //   }
  // }
}
