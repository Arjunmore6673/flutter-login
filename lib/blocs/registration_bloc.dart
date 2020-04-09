import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:flutterapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

enum RegistrationEvents { register }

class RegistrationBloc {
  final _repository = Repository();
  final _registrationRes = PublishSubject<int>();

  Stream<int> get registrationResponse => _registrationRes.stream;

    saveRegistration(RegistrationModel model) async {
    int response = await _repository.submitRegistration(model);
    print("response " + response.toString());
    _registrationRes.sink.add(response);
  }

  dispose() {
    _registrationRes.close();
  }
}

final registrationBloc =  RegistrationBloc();
