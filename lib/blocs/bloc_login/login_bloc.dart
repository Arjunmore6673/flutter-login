import 'dart:async';

import 'package:flutterapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutterapp/blocs/auth_bloc/auth_event.dart';
import 'package:flutterapp/blocs/bloc_login/login_event.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}