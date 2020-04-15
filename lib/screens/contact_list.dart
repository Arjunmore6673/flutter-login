import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterapp/screens/searched_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> _contacts;

  @override
  initState() {
    super.initState();
    refreshContacts();
  }

  refreshContacts() async {
    if (await Permission.contacts.isGranted) {
      print("granted");
      var contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
      var cc = contacts
          .where(
            (i) =>
                regularExpression(i.displayName, 'mami') ||
                regularExpression(i.displayName, 'kaka') ||
                regularExpression(i.displayName, 'mavshi') ||
                regularExpression(i.displayName, 'mama') ||
                regularExpression(i.displayName, 'sister') ||
                regularExpression(i.displayName, 'bro') ||
                regularExpression(i.displayName, 'brother') ||
                regularExpression(i.displayName, 'siso') ||
                regularExpression(i.displayName, 'didi'),
          )
          .toList();
      setState(() {
        _contacts = cc;
      });

      // Lazy load thumbnails after rendering initial contacts.
      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return; // Don't redraw if no change.
          setState(() => contact.avatar = avatar);
        });
      }
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
        child: _contacts != null
            ? ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: ScaleAnimation(
                        child: SearchedContacts(contact: _contacts[index]),
                      ),
                    ),
                  );
                },
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
    );
  }
}
