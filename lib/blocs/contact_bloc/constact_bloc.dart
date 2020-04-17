import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/contact_bloc/contact_event.dart';
import 'package:flutterapp/blocs/contact_bloc/contact_state.dart';
import 'package:flutterapp/repository/user_repo.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  UserRepository userRepository;
  ContactBloc({@required this.userRepository});
  @override
  ContactState get initialState => ContactIntialState();

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is GetContactList) {
      yield ContactLoading();
      print("getting ");
      List<Contact> contactList = await userRepository.getContactList();
      yield ContactLoaded(contacts: contactList);
      print("Loaded ");
    }
  }
}
