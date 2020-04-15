import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/common/CardCommon.dart';
import 'package:flutterapp/screens/common/TextCommon.dart';

class SearchedContacts extends StatefulWidget {
  final Contact contact;

  SearchedContacts({@required this.contact});

  @override
  _SearchedContactsState createState() => _SearchedContactsState();
}

class _SearchedContactsState extends State<SearchedContacts> {
  List<bool> isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = [true, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: getStack(),
            ),
            Expanded(
              child: getStack(),
            ),
          ],
        ),
      ],
    ));
  }

  Widget getStack() {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 1, top: 10, right: 1, bottom: 10),
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
                              backgroundImage:
                                  MemoryImage(widget.contact.avatar),
                              radius: 40)
                          : CircleAvatar(
                              child: Text(widget.contact.initials()),
                              radius: 40),
                      TextCommon(
                          text: widget.contact.displayName, fontSize: 20),
                      TextCommon(
                          text: widget.contact.phones.elementAt(0).value,
                          fontSize: 18),
                      SizedBox(height: 10),
                      Container(
                        height: 35,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ToggleButtons(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              constraints:
                                  BoxConstraints(maxHeight: 30, minHeight: 30),
                              selectedColor: Colors.yellow,
                              highlightColor: Colors.white,
                              borderColor: Colors.transparent,
                              children: <Widget>[
                                Card(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text("MAVAS"),
                                  ),
                                ),
                                Card(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text("MAVAS"),
                                  ),
                                ),
                                Card(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text("MAVAS"),
                                  ),
                                ),
                                Card(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text("MAVAS"),
                                  ),
                                ),
                                Card(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text("MAVAS"),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 0, right: 10, bottom: 15),
                        child: TextFormField(
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
          Container(
            width: 100,
            child: RaisedButton(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.save,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 10),
                  Text('save',
                      style: TextStyle(color: Colors.blue, fontSize: 18)),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
