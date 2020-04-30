import 'package:flutter/material.dart';
import 'package:flutterapp/app_theme.dart';
import 'package:flutterapp/custom_drawer/drawer_user_controller.dart';
import 'package:flutterapp/custom_drawer/home_drawer.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/screens/chat/chat_screen.dart';
import 'package:flutterapp/screens/contact/contact_list.dart';
import 'package:flutterapp/screens/drawer_screens/about_us.dart';
import 'package:flutterapp/screens/drawer_screens/feedback_screen.dart';
import 'package:flutterapp/screens/drawer_screens/help_screen.dart';
import 'package:flutterapp/screens/drawer_screens/invite_friend_screen.dart';
import 'package:flutterapp/screens/relation/relation_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
      InviteFriend(),
      AboutUs(),
      ChatListPage()
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

          bottomNavigationBar: AnimatedBottomNav(
            currentIndex: currentPage,
            onChange: (index) {
              if (index == 1) {
                _listenForPermissionStatus();
              }
              setState(() {
                currentPage = index;
              });
            },
          ),

          // bottomNavigationBar: FancyBottomNavigation(
          //   tabs: [
          //     TabData(
          //       iconData: Icons.home,
          //       title: "Home",
          //       onclick: () {
          //         final FancyBottomNavigationState fState =
          //             bottomNavigationKey.currentState;
          //         fState.setPage(0);
          //       },
          //     ),
          //     TabData(
          //       iconData: Icons.contacts,
          //       title: "Contacts",
          //       onclick: () {
          //         final FancyBottomNavigationState fState =
          //             bottomNavigationKey.currentState;
          //         fState.setPage(1);
          //       },
          //     )
          //   ],
          //   initialSelection: 0,
          //   key: bottomNavigationKey,
          //   onTabChangedListener: (position) {
          //     setState(() {
          //       currentPage = position;
          //     });
          //   },
          // ),
        ),
      ),
    );
  }

  void _listenForPermissionStatus() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print("status is granted ");
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Contact Permissino Required"),
        content: Text('We need Contact permission to show contact list '),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Permission.contacts.request();
            },
          )
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
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
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          // screenView = InviteFriend();
          currentPage = 5;
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

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;

  const AnimatedBottomNav({Key key, this.currentIndex, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: HexColor("#f9f9f9")),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: BottomNavItem(
                icon: Icons.home,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: BottomNavItem(
                icon: Icons.people,
                title: "Contacts",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(6),
              child: BottomNavItem(
                icon: Icons.chat,
                title: "Chat",
                isActive: currentIndex == 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final String title;

  const BottomNavItem(
      {Key key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive
          ? Container(
              color: HexColor("#f9f9f9"),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? Colors.grey,
            ),
    );
  }
}
