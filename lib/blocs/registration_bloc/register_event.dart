import 'package:equatable/equatable.dart';
import 'package:flutterapp/model/RegistrationModel.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final RegistrationModel model;

  RegisterButtonPressed({this.model});

  @override
  List<Object> get props => [model];
}
