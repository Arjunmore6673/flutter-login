import 'package:equatable/equatable.dart';

class ContactEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetContactList extends ContactEvent {}

class RemovedContact extends ContactEvent {}
