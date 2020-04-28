import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends RegisterState {}

class Loading extends RegisterState {}

class RegistrationError extends RegisterState {
  final String error;

  RegistrationError({this.error});

  @override
  List<Object> get props => [error];
}

class RegistrationSuccessfully extends RegisterState {}
