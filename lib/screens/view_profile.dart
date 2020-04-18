import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/ExpandableCardCommon.dart';
import 'package:flutterapp/screens/common/ProfileImgAndDetailsCommon.dart';

class ViewProfile extends StatelessWidget {
  final RelationModel model;
  ViewProfile({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => RelationBloc(
          UserRepository(),
        )..add(RelationListPressed(userId: 1)),
        child: getProfileWidget(),
      ),
    );
  }

  getProfileWidget() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatarCommon(model.image == null
                  ? 'https://thehuboncanal.org/wp-content/uploads/2016/11/FEMALE-PERSON-PLACEHOLDER.jpg'
                  : model.image),
              SizedBox(height: 30),
              TextView(text: "${model.name}", fontFamily: 'Mali', fontSize: 30),
              SizedBox(height: 10),
              TextView(text: "${model.mobile}", fontFamily: 'Roboto'),
              SizedBox(height: 10),
              TextView(text: "${model.email}", fontFamily: 'Roboto'),
              SizedBox(height: 10),
              TextView(text: "Pune maharashtra", fontFamily: 'Roboto'),
              SizedBox(height: 10),
              TextView(text: "${model.relation}", fontFamily: 'Roboto'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 35.0,
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text('Call', style: TextStyle(color: Colors.black)),
                          SizedBox(width: 10),
                          Icon(Icons.call),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 35.0,
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.message),
                          SizedBox(width: 10),
                          Text('Message',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: BlocBuilder<RelationBloc, RelationState>(
            builder: (context, state) {
              if (state is RelationLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RelationLoadFailureState) {
                return Text("error..");
              }
              if (state is RelationLoadedState) {
                return getThirdBloc(state.data);
              }
              return Text("initial ");
            },
          ),
        ),
      ],
    );
  }

  Widget getThirdBloc(Map<String, Object> data) {
    List<RelationModel> mamaMami = data["mamaMami"];
    List<RelationModel> kakaMavshi = data["kakaMavshi"];
    List<RelationModel> broSis = data["broSis"];
    List<RelationModel> other = data["other"];
    List<RelationModel> total = [];
    total.addAll(mamaMami);
    total.addAll(kakaMavshi);
    total.addAll(broSis);
    total.addAll(other);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: total.length,
      itemBuilder: (BuildContext context, int index) {
        return ProfileImgAndDetails(
          userModel: total[index],
          onPress: () {
            onPressFunction(context, total[index]);
          },
        );
      },
    );
  }

  onPressFunction(BuildContext context, RelationModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewProfile(model: model)),
    );
  }
}

class TextView extends StatelessWidget {
  const TextView(
      {Key key,
      @required this.text,
      this.fontFamily = 'Ink free',
      this.fontSize = 20})
      : super(key: key);
  final String text;
  final String fontFamily;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
