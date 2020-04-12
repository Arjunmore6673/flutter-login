import 'package:flutter/material.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/screens/common/CardCommon.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/UserDeatils.dart';

class ProfileImgAndDetails extends StatelessWidget {
  final RelationModel userModel;

  const ProfileImgAndDetails({
    Key key,
    @required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CircleAvatarCommon(userModel.image),
        CardCommon(
          child: UserDeatils(mainTitle: userModel.name, widgets: [
            Text(
              userModel.email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            Text(
              userModel.mobile,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
