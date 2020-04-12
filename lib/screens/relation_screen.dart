import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/add_relation_screen.dart';

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
    //final relnBloc = BlocProvider.of<RelationBloc>(context);
    return Scaffold(
        body: DefaultBottomBarController(
      child: Page(),
    ));
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocProvider(
        create: (BuildContext context) => RelationBloc(UserRepository()),
        child: Container(
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
                      .add(RelationListPressed(userId: 1));
                  return Text("EMPTY");
                }
                if (state is RelationLoadingState) {
                  return Text("Loading..");
                }
                if (state is RelationLoadFailureState) {
                  return Text("error..");
                }
                if (state is RelationLoadedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          flex: 1, child: getFirstBloc(state.data["user"])),

                      /// state.data is map of  mama/mami,  kaka/mavshi, brother/sister
                      Expanded(flex: 2, child: getThirdBloc(state.data)),
                    ],
                  );
                }
                return Text("initial ");
              },
            ),
          ),
        ),
      ),

      //Set to true for bottom appbar overlap body content
      extendBody: true,

      // Lets use docked FAB for handling state of sheet
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        // Set onVerticalDrag event to drag handlers of controller for swipe effect
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: FloatingActionButton.extended(
          label: Text("Add"),
          elevation: 2,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          //Set onPressed event to swap state of bottom bar
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),

      // Actual expandable bottom bar
      bottomNavigationBar: BottomExpandableAppBar(
        expandedHeight: 550,
        horizontalMargin: 16,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        expandedBackColor: Theme.of(context).backgroundColor,
        expandedBody: Center(
          child: AddRelation(),
        ),
        bottomAppBarBody: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Tets",
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Expanded(
                child: Text(
                  "Stet",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
    List<RelationModel> daji = data["daji"];
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
              return ProfileImgAndDetails(userModel: mamaMami[index]);
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
              return ProfileImgAndDetails(userModel: kakaMavshi[index]);
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
              return ProfileImgAndDetails(userModel: broSis[index]);
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
              return ProfileImgAndDetails(userModel: other[index]);
            },
          ),
        ),
      ],
    );
  }
}
