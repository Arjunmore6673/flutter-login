import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/view_profile.dart';

import 'common/ExpandableCardCommon.dart';
import 'common/ProfileImgAndDetailsCommon.dart';

class RelationScreen extends StatefulWidget {
  RelationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RelationScreenState();
}

class RelationScreenState extends State<RelationScreen> {
  String i =
      "https://lh3.googleusercontent.com/proxy/icdlNc79c98KgJ3xsNW6kaMOqfJwMD13268O9PtXdadc8mYDyby9ai_Pb_h7Yp0LQDNsFcgMc-_2TS-msAtLZ-kGxsz_8hJ5gPF4ikP0cyrxO8PLC63tH2f-0sKVLUFzjd5Ld_dWkh9Z8wjcLtyICgBLjSeroYhZe8UXc4_i_WbCtnJn";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => RelationBloc(
          UserRepository(),
        ),
        child: Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Container(
          child: BlocListener<RelationBloc, RelationState>(
            /// listener to listen failure events
            listener: (context, state) {
              if (state is RelationLoadFailureState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<RelationBloc, RelationState>(
              builder: (context, state) {
                if (state is RelationEmptyState) {
                  BlocProvider.of<RelationBloc>(context)
                      .add(RelationListPressed(userId: -1));
                  return Text("EMPTY");
                }
                if (state is RelationLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is RelationLoadFailureState) {
                  return Text("error..");
                }
                if (state is RelationLoadedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          flex: 2, child: getFirstBloc(state.data["user"])),

                      /// state.data is map of  mama/mami,  kaka/mavshi, brother/sister
                      Expanded(flex: 3, child: getThirdBloc(state.data)),
                    ],
                  );
                }
                return Text("initial ");
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getFirstBloc(RelationModel userModel) {
    return ProfileImgAndDetails(userModel: userModel);
  }

  Widget getSecondBloc() {
    return Container(
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(color: Colors.red),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: RaisedButton(
            color: Colors.purple,
            onPressed: () {},
            child: Text(
              "Add Relation",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget getThirdBloc(Map<String, Object> data) {
    List<RelationModel> mamaMami = data["mamaMami"];
    List<RelationModel> kakaMavshi = data["kakaMavshi"];
    List<RelationModel> broSis = data["broSis"];
    List<RelationModel> other = data["other"];

    return ListView(
      children: <Widget>[
        ExpandableCardCommon(
          length: mamaMami.length,
          text: "MAMA / MAMI",
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mamaMami.length,
            itemBuilder: (BuildContext context, int index) {
              return ProfileImgAndDetails(
                userModel: mamaMami[index],
                onPress: () {
                  onPressFunction(context, mamaMami[index]);
                },
              );
            },
          ),
        ),

        /// second view
        ExpandableCardCommon(
          length: kakaMavshi.length,
          text: "KAKA / MAVSHI",
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kakaMavshi.length,
            itemBuilder: (BuildContext context, int index) {
              return ProfileImgAndDetails(
                userModel: kakaMavshi[index],
                onPress: () {
                  onPressFunction(context, kakaMavshi[index]);
                },
              );
            },
          ),
        ),

        /// third view
        ExpandableCardCommon(
          length: broSis.length,
          text: "BROTHER / SISTER",
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: broSis.length,
            itemBuilder: (BuildContext context, int index) {
              return ProfileImgAndDetails(
                userModel: broSis[index],
                onPress: () {
                  onPressFunction(context, broSis[index]);
                },
              );
            },
          ),
        ),

        /// FOURTH view
        ExpandableCardCommon(
          length: other.length,
          text: "OTHER",
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: other.length,
            itemBuilder: (BuildContext context, int index) {
              return ProfileImgAndDetails(
                userModel: other[index],
                onPress: () {
                  onPressFunction(context, other[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  onPressFunction(BuildContext context, RelationModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewProfile(model: model)),
    );
  }
}
