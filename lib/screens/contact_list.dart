import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterapp/screens/searched_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage>
    with AutomaticKeepAliveClientMixin {
  List<Contact> _contacts;
  List<Contact> contactsAll;
  List<Contact> deleted;

  @override
  initState() {
    super.initState();
    refreshContacts();
  }

  @override
  bool get wantKeepAlive => true;

  removedContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listDeleted = prefs.getStringList("DELETED");
    var deletedList = contactsAll
        .where((test) => listDeleted.contains(test.displayName))
        .toList();
    setState(() {
      _contacts = deletedList;
    });
  }

  refreshContacts() async {
    if (await Permission.contacts.isGranted) {
      print("granted");
      contactsAll =
          (await ContactsService.getContacts(withThumbnails: false)).toList();

      var keys = [
        'mami',
        'mama',
        'kaka',
        'mavshi',
        'sister',
        'siso',
        'didi',
        'tai',
        'bro',
        'bhaiya',
        'brother',
        'aatya',
        'aai',
        'mother',
        'mom',
        'papa',
        'pappa',
        'baba',
        'father'
      ];

      var regex =
          new RegExp("\\b(?:${keys.join('|')})\\b", caseSensitive: false);
      var contactsRelatives =
          contactsAll.where((i) => regex.hasMatch(i.displayName)).toList();

      List<Contact> contactsRelativesAddedRelatives = [];
      for (var i = 0; i < contactsRelatives.length; i++) {
        Contact obj = contactsRelatives[i];
        if (regularExpression(obj.displayName, "mami")) {
          obj.familyName = "MAMI";
          obj.jobTitle = "FEMALE";
        } else if (regularExpression(obj.displayName, "MAMA")) {
          obj.familyName = "MAMA";
          obj.jobTitle = "MALE";
        } else if (regularExpression(obj.displayName, "KAKA")) {
          obj.familyName = "KAKA";
          obj.jobTitle = "MALE";
        } else if (regularExpression(obj.displayName, "SISTER") ||
            regularExpression(obj.displayName, 'tai') ||
            regularExpression(obj.displayName, 'siso') ||
            regularExpression(obj.displayName, 'didi')) {
          obj.familyName = "SISTER";
          obj.jobTitle = "FEMALE";
        } else if (regularExpression(obj.displayName, "bro") ||
            regularExpression(obj.displayName, 'brother') ||
            regularExpression(obj.displayName, 'bhaiya') ||
            regularExpression(obj.displayName, 'dada')) {
          obj.familyName = "BROTHER";
          obj.jobTitle = "MALE";
        } else if (regularExpression(obj.displayName, "aatya")) {
          obj.familyName = "AATYA";
          obj.jobTitle = "FEMALE";
        } else if (regularExpression(obj.displayName, "daji")) {
          obj.familyName = "DAJI";
          obj.jobTitle = "MALE";
        } else if (regularExpression(obj.displayName, "mavshi")) {
          obj.familyName = "MAVSHI";
          obj.jobTitle = "FEMALE";
        } else if (regularExpression(obj.displayName, "aai") ||
            regularExpression(obj.displayName, "mother") ||
            regularExpression(obj.displayName, "mom")) {
          obj.familyName = "MOTHER";
          obj.jobTitle = "FEMALE";
        } else if (regularExpression(obj.displayName, "papa") ||
            regularExpression(obj.displayName, "papaa") ||
            regularExpression(obj.displayName, "father") ||
            regularExpression(obj.displayName, "baba")) {
          obj.familyName = "FATHER";
          obj.jobTitle = "male";
        }
        contactsRelativesAddedRelatives.add(obj);
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> listDeleted = prefs.getStringList("DELETED");
      if (listDeleted == null) {
        listDeleted = [];
      }
      var filteredList = contactsRelativesAddedRelatives
          .where((test) => !listDeleted.contains(test.displayName))
          .toList();

      setState(() {
        _contacts = filteredList;
      });

      // Lazy load thumbnails after rendering initial contacts.
//      for (final contact in contactsAll) {
//        ContactsService.getAvatar(contact).then((avatar) {
//          if (avatar == null) return; // Don't redraw if no change.
//          setState(() => contact.avatar = avatar);
//        });
//      }
    } else {
      print("he dont have persmission");
    }
  }

  bool regularExpression(String stringg, String search) {
    RegExp exp = new RegExp(
      "\\b" + search + "\\b",
      caseSensitive: false,
    );
    return exp.hasMatch(stringg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _contacts != null
                ? GridView.count(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height),
                    crossAxisCount: 2,
                    children: List.generate(
                      _contacts?.length ?? 0,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: SearchedContacts(
                                contact: _contacts[index],
                                onDelete: () => removeItem(index),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )

                // ListView.builder(
                //     itemCount: _contacts?.length ?? 0,
                //     itemBuilder: (BuildContext context, int index) {
                //       Contact c = _contacts?.elementAt(index);
                //       return ListTile(
                //         onTap: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (BuildContext context) =>
                //                   ContactDetailsPage(c)));
                //         },
                //         leading: (c.avatar != null && c.avatar.length > 0)
                //             ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                //             : CircleAvatar(child: Text(c.initials())),
                //         title: Text(c.displayName ?? ""),
                //       );
                //     },
                //   )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      )),
    );
  }

  removeItem(int index) async {
    print("index " + index.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList("DELETED");
    if (list == null) list = [];
    list.add(_contacts[index].displayName);
    await prefs.setStringList("DELETED", list);
    setState(() {
      _contacts = List.from(_contacts)..removeAt(index);
    });
  }
}
