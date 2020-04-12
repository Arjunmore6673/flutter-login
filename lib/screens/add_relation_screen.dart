import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/repository/user_repo.dart';

class AddRelation extends StatefulWidget {
  AddRelation({Key key}) : super(key: key);

  @override
  _AddRelationState createState() => _AddRelationState();
}

class _AddRelationState extends State<AddRelation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RelationBloc((UserRepository())),
      child: RelationWidget(con: context),
    );
  }
}

class RelationWidget extends StatelessWidget {
  final BuildContext con;
  RelationWidget({this.con});
  @override
  Widget build(BuildContext con) {
    return Container(
        child: BlocListener<RelationBloc, RelationState>(
      listener: (con, state) {
        if (state is RelationAddedState) {
          Scaffold.of(con).showSnackBar(
            SnackBar(
              content: Text('aDDED sUCCESSfullY'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is RelationLoadFailureState) {
          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("My title"),
            content: Text('sOMTHING SUCKED' + state.error),
            actions: [],
          );

          showDialog(
            context: con,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        margin: EdgeInsets.all(0),
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                name(),
                mobile(),
                address(),
                state(),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: RaisedButton(
                    child: Text("Save"),
                    elevation: 8,
                    color: Colors.white,
                    onPressed: () {
                      BlocProvider.of<RelationBloc>(con).add(RelationAddPressed(
                          name: "ARjunMore",
                          mobile: "313113",
                          address: "puneeee",
                          relation: "SON"));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget state() {
    return DropdownButton<String>(
      hint: Text("Select Relation"),
      isExpanded: true,
      items: <String>[
        'MAMA',
        'MAMI',
        'KAKA',
        'MAVSHI',
        'BROTHER',
        'SISTER',
        'PAPA',
        'MOTHER',
      ].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget city() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text("Select City"),
      items: <String>['pune', 'satara', 'mumbai'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget address() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Address",
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget name() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        errorText: "",
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email address",
        hintText: "rockajm@gmail.com",
        errorText: "",
      ),
      validator: (value) {
        if (!value.contains('@'))
          return "Please enter email";
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget mobile() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Mobile number",
        errorText: "",
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget passwordField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: "password",
        ),
        validator: (value) {
          if (value.length < 5)
            return "Please enter valid password";
          else
            return null;
        },
        keyboardType: TextInputType.visiblePassword);
  }
}
