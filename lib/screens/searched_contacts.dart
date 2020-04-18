import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/CardCommon.dart';
import 'package:flutterapp/screens/common/TextCommon.dart';

class SearchedContacts extends StatefulWidget {
  final Contact contact;
  final String relation;
  final VoidCallback onDelete;

  SearchedContacts(
      {@required this.contact, this.relation, @required this.onDelete});

  @override
  _SearchedContactsState createState() => _SearchedContactsState();
}

class _SearchedContactsState extends State<SearchedContacts> {
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false, false];
  }

  getSelectedRelation() {
    String relation;
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (isSelected[0] == true) {
        relation = 'MAVAS BHAU';
      } else if (isSelected[1] == true) {
        relation = 'CHULAT BHAU';
      } else if (isSelected[1] == true) {
        relation = 'MAME BHAU';
      }
      return relation;
    }
  }

  intialize() {}
  final villageCityTextBox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext ccc) => RelationBloc(UserRepository()),
        child: BlocListener<RelationBloc, RelationState>(
          /// listener to listen failure events
          listener: (ccc, state) {
            if (state is RelationLoadFailureState) {
              Scaffold.of(ccc).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is RelationAddedState) {
              widget.onDelete();
               Scaffold.of(ccc).showSnackBar(
                SnackBar(
                  content: Text("Added successfully"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<RelationBloc, RelationState>(
            builder: (ccc, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getStack(ccc),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getStack(BuildContext ccc) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 1, top: 0, right: 1, bottom: 10),
          // color: Colors.green,
          child: Column(
            children: <Widget>[
              CardCommon(
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    (widget.contact.avatar != null &&
                            widget.contact.avatar.length > 0)
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(widget.contact.avatar),
                            radius: 40)
                        : CircleAvatar(
                            child: Text(widget.contact.initials()), radius: 40),
                    TextCommon(text: widget.contact.displayName, fontSize: 20),
                    TextCommon(
                        text: widget.contact.phones.elementAt(0).value,
                        fontSize: 18),
                    SizedBox(height: 10),
                    (regularExpression(widget.contact.displayName, "bhau") ||
                            regularExpression(
                                widget.contact.displayName, "brother") ||
                            regularExpression(
                                widget.contact.displayName, "bro"))
                        ? Container(
                            height: 35,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ToggleButtons(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  constraints: BoxConstraints(
                                      maxHeight: 30, minHeight: 30),
                                  selectedColor: Colors.yellow,
                                  highlightColor: Colors.white,
                                  borderColor: Colors.transparent,
                                  children: <Widget>[
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("MAVAS Bhau"),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Chulat Bhau"),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Mame Bhau"),
                                      ),
                                    ),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: isSelected,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    (regularExpression(widget.contact.displayName, "sister") ||
                            regularExpression(
                                widget.contact.displayName, "siso") ||
                            regularExpression(
                                widget.contact.displayName, "didi"))
                        ? Container(
                            height: 35,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ToggleButtons(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  constraints: BoxConstraints(
                                      maxHeight: 30, minHeight: 30),
                                  selectedColor: Colors.yellow,
                                  highlightColor: Colors.white,
                                  borderColor: Colors.transparent,
                                  children: <Widget>[
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("MAVAS Bahin"),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Chulat Bahin"),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Mame Bahin"),
                                      ),
                                    ),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: isSelected,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5, top: 0, right: 5, bottom: 15),
                      child: TextFormField(
                        controller: villageCityTextBox,
                        decoration: InputDecoration(
                          labelText: "Enter Village, city",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -20,
          right: -20,
          child: GestureDetector(
            onTap: widget.onDelete,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: CardCommon(
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          alignment: Alignment.center,
          child: RaisedButton(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.save,
                  color: Colors.orange,
                ),
                SizedBox(width: 5),
                Text('save',
                    style: TextStyle(color: Colors.blue, fontSize: 18)),
              ],
            ),
            onPressed: () {
              print("ontap frjkldjfk j");
              if (villageCityTextBox.text.length > 0) {
                BlocProvider.of<RelationBloc>(ccc).add(RelationAddPressed(
                    name: widget.contact.displayName,
                    mobile: widget.contact.phones.elementAt(0).value,
                    email: '',
                    address: villageCityTextBox.text,
                    relation: getSelectedRelation(),
                    avtar: "widget.contact.avatar"));
              } else {
                print("else");
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please Enter village and Select relation"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  bool regularExpression(String stringg, String search) {
    RegExp exp = new RegExp(
      "\\b" + search + "\\b",
      caseSensitive: false,
    );
    return exp.hasMatch(stringg);
  }
}
