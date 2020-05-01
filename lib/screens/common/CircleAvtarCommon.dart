import 'package:flutter/material.dart';

class CircleAvatarCommon extends StatelessWidget {
  final String url;
  final double redius;
  final bool assetImage;

  CircleAvatarCommon({this.url, this.redius = 60.0, this.assetImage = false});

  @override
  Widget build(BuildContext context) {
    // print("url " + url);
    return Padding(
      padding: EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundImage: !assetImage ? NetworkImage(url) : AssetImage(url),
        radius: redius,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
