import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/registration_bloc/register_event.dart';
import 'package:flutterapp/blocs/registration_bloc/register_state.dart';
import 'package:flutterapp/repository/user_repo.dart';

class RegistrationBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegistrationBloc({@required this.userRepository});

  @override
  RegisterState get initialState => InitialState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      try {
        print("Loading ...");
        yield Loading();
        print("model : " + event.model.toString());
        String message = await userRepository.registerUser(event.model);
        print(message + "in bloc ");
        yield RegistrationSuccessfully();
        print("RegistrationSuccessfully ...");
      } catch (e) {
        print("RegistrationError ..." + e.toString());
        yield RegistrationError(error: e.toString());
      }
    }
  }
}
