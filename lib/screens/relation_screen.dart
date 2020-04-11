import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';

class RelationScreen extends StatefulWidget {
  RelationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RelationScreenState();
}

class RelationScreenState extends State<RelationScreen> {
  @override
  Widget build(BuildContext context) {
    //final relnBloc = BlocProvider.of<RelationBloc>(context);

    return BlocProvider(
        create: (BuildContext context) => RelationBloc(UserRepository()),
        child:
            BlocBuilder<RelationBloc, RelationState>(builder: (context, state) {
          if (state is RelationEmptyState) {
            BlocProvider.of<RelationBloc>(context)
                .add(RelationListPressed(userId: 1));
            return Text("EMpty");
          }
          if (state is RelationLoadingState) {
            return Text("Loading..");
          }
          if (state is RelationLoadFailureState) {
            return Text("error..");
          }
          if (state is RelationLoadedState) {
            RelationModel userModel = state.data["user"];
            print(userModel.toString());
            return Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 90.0,
                        backgroundColor: Colors.red,
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              // topRight: Radius.circular(40.0),
                              ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${userModel.getName}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                '${userModel.getEmail}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                '${userModel.mobile}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return circleAvtar(state.data["relations"], index);
                    },
                  ),
                  flex: 1,
                ),
              ],
            );
          }
          return Text("initial ");
        }));
  }

  Widget getListView(data) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        SizedBox(width: 10),
        SizedBox(width: 10),
      ],
    );
  }

  Widget getContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                // child: circleAvtar(),
              ),
              // Expanded(child: personDetails()),
            ],
          )),
    );
  }

  Widget circleAvtar(List<RelationModel> data, int index) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 90.0,
          backgroundColor: Colors.transparent,
        ),
        personDetails(data, index)
      ],
    );
  }

  Widget personDetails(List<RelationModel> data, int index) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // topRight: Radius.circular(40.0),
            ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '${data[index].getName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Text(
              "Mama",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
