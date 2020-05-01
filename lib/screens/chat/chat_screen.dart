import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/screens/chat/chat.dart';
import 'package:flutterapp/screens/chat/const.dart';
import 'package:flutterapp/screens/drawer_screens/navigation_home_screen.dart';
import 'package:flutterapp/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// chat screen

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key});

  String currentUserId;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getFirebaseId();
    registerNotification();
    configLocalNotification();
  }

  getFirebaseId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString(Constants.USER_FIREBASE_ID);
  }

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      Platform.isAndroid
          ? showNotification(message['notification'])
          : showNotification(message['aps']['alert']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      print('currentUserId: $currentUserId');
      Firestore.instance
          .collection('users')
          .document(currentUserId)
          .updateData({'pushToken': token});
    }).catchError((err) {
      // Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    // var initializationSettingsAndroid =
    //     new AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = new IOSInitializationSettings();
    // var initializationSettings = new InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOS);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void onItemMenuPress(Choice choice) {
    // if (choice.title == 'Log out') {
    //   handleSignOut();
    // } else {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Settings()));
    // }
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });


    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationBloc, RelationState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 90),
            child: WillPopScope(
              child: Stack(
                children: <Widget>[
                  // List
                  Container(
                      child: state is RelationLoadedState
                          ? getLIstView(state.data)
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(themeColor),
                              ),
                            )),

                  // Loading
                  Positioned(
                    child: isLoading
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      themeColor)),
                            ),
                            color: Colors.white.withOpacity(0.8),
                          )
                        : Container(),
                  )
                ],
              ),
              onWillPop: onBackPress,
            ),
          ),
        );
      },
    );
  }

  Widget getLIstView(Map<String, Object> data) {
    List<RelationModel> finalList = new List();
    finalList.clear();
    List<RelationModel> mamaMami = data["mamaMami"];
    List<RelationModel> kakaMavshi = data["kakaMavshi"];
    List<RelationModel> broSis = data["broSis"];
    List<RelationModel> other = data["other"];
    finalList.addAll(mamaMami);
    finalList.addAll(kakaMavshi);
    finalList.addAll(broSis);
    finalList.addAll(other);
    print("document============================>" + other.toString());
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) => buildItem(context, finalList[index]),
      itemCount: finalList.length,
    );
  }

  Widget buildItem(BuildContext context, RelationModel document) {
    if (document.firebaseId == currentUserId) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: document.image != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document.image,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: greyColor,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname: ${document.name}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${document.email ?? 'Not available'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chat(
                  peerId: document.firebaseId,
                  peerAvatar: document.image == null || document.image == ""
                      ? "https://cdn.shopify.com/s/files/1/1061/1924/products/Smiling_Face_Emoji_large.png?v=1571606036"
                      : document.image,
                ),
              ),
            );
          },
          color: greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
