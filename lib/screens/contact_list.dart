import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterapp/blocs/contact_bloc/constact_bloc.dart';
import 'package:flutterapp/blocs/contact_bloc/contact_event.dart';
import 'package:flutterapp/blocs/contact_bloc/contact_state.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/loading.dart';
import 'package:flutterapp/screens/searched_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> _contacts;
  List<Contact> contactsAll;
  List<Contact> deleted;

  @override
  initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return ContactBloc(userRepository: UserRepository())
          ..add(GetContactList());
      },
      child: SafeArea(child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return LoadingIndicator();
          }
          if (state is ContactLoaded) {
            return getColumn(state.contacts);
          }
          return LoadingIndicator();
        },
      )),
    ));
  }

  Widget getColumn(List<Contact> contacts) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: contacts != null
              ? GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                  crossAxisCount: 2,
                  children: List.generate(
                    contacts?.length ?? 0,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: SearchedContacts(
                              contact: contacts[index],
                              onDelete: () => removeItem(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }

  removeItem(int index) async {
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
