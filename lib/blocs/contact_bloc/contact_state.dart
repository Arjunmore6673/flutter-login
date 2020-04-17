import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ContactState extends Equatable {
  @override
  List<Object> get props => [];
}

class ContactIntialState extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;
  ContactLoaded({@required this.contacts});
  @override
  List<Object> get props => [contacts];
}

class ContactLoadedWithAvtar extends ContactState {
  final List<Contact> contacts;
  ContactLoadedWithAvtar({@required this.contacts});
  @override
  List<Object> get props => [contacts];
}

class ContactLoadFailure extends ContactState {
  final String error;
  ContactLoadFailure({this.error});
  @override
  List<Object> get props => [error];
}
