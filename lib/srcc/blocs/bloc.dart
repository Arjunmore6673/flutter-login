//import 'dart:async';
//import 'package:rxdart/rxdart.dart';
//
//import 'package:flutterapp/src/bloc/validators.dart';
//
//class Bloc extends Object with Validators {
//  final _email = StreamController<String>();
//  final _pass = StreamController<String>();
//  //add data to stream
//  Stream<String> get email => _email.stream.transform(validatorEmail);
//  Stream<String> get password => _pass.stream.transform(validatePassword);
//
//  Stream<bool> get submitValid => Observable.combine
//
//  //change data
//  Function(String) get changeEmail => _email.sink.add;
//
//  Function(String) get changePassword => _pass.sink.add;
//
//  void dispose() {
//    _email.close();
//    _pass.close();
//  }
//}
//
//final bloc = Bloc();
