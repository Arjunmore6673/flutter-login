import 'package:flutter/material.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/screens/common/CardCommon.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/UserDeatils.dart';

class ProfileImgAndDetails extends StatelessWidget {
  final RelationModel userModel;
  final Function onPress;

  const ProfileImgAndDetails({Key key, @required this.userModel, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          (userModel.image == null)
              ? CircleAvatarCommon(
                  assetImage: true,
                  url: (userModel.gender == 'MALE'
                      ? 'assets/images/place.jpg'
                      : 'assets/images/place.jpg'))
              : CircleAvatarCommon(url: userModel.image),
          CardCommon(
            child: UserDeatils(mainTitle: userModel.name, widgets: [
              userModel.email != null
                  ? Text(
                      userModel.email,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  : SizedBox(),
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
      ),
    );
  }
}
