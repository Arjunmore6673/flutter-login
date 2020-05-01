import 'package:flutterapp/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                CircleAvatarCommon(
                  url: 'assets/images/Relatives.png',
                  assetImage: true,
                  redius: 70,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'About us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    "We are trying to connect all Realtives\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
