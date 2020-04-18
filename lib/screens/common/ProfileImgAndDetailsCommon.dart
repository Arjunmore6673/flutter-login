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
          CircleAvatarCommon(userModel.image == null
              ? 'https://thehuboncanal.org/wp-content/uploads/2016/11/FEMALE-PERSON-PLACEHOLDER.jpg'
              : userModel.image),
          CardCommon(
            child: UserDeatils(mainTitle: userModel.name, widgets: [
              userModel.email.length > 0
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
