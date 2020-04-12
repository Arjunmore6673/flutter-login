import 'package:flutter/material.dart';

class CircleAvatarCommon extends StatelessWidget {
  final String url;
  final double redius;

  CircleAvatarCommon(this.url, [double redius]) : this.redius = redius ?? 60.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundImage: NetworkImage(url),
        radius: redius,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
