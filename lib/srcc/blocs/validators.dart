import 'dart:async';

class Validators {
  final validatorEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError("Enter valid email address");
    }
  });

  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (pass.length > 4) {
      sink.add(pass);
    } else {
      sink.addError("length should be grater than 4");
    }
  });
}
