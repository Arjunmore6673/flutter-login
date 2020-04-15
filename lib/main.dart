import 'dart:io';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/loading.dart';
import 'package:flutterapp/screens/login_page.dart';
import 'package:flutterapp/screens/navigation_home_screen.dart';
import 'package:flutterapp/screens/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/auth_bloc/auth_event.dart';
import 'blocs/auth_bloc/auth_state.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(userRepository: userRepository)
              ..add(AppStarted());
          },
          child: MyAppNew(userRepository: userRepository),
        ),
      ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                // return AddRelation();
                //return ViewProfile();
                // return RelationScreen();
                // return ContactListPage();
                // return NavigationHomeScreen();
                return NavigationHomeScreen();
              }
              if (state is AuthenticationUnauthenticated) {
                // return RelationScreen();
                return LoginPage(userRepository: userRepository);
              }
              if (state is AuthenticationLoading) {
                return LoadingIndicator();
              }
              return Text("something wrong");
            },
          ),
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class MyAppNew extends StatefulWidget {
  final UserRepository userRepository;
  MyAppNew({Key key, @required this.userRepository}) : super(key: key);
  @override
  _MyAppNewState createState() =>
      _MyAppNewState(key: key, userRepository: userRepository);
}

class _MyAppNewState extends State<MyAppNew> {
  final UserRepository userRepository;
  _MyAppNewState({Key key, @required this.userRepository});

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print("status is granted ");
    } else {
      print("request  contacts ");
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              // return AddRelation();
              //return ViewProfile();
              // return RelationScreen();
              //  return ContactListPage();
              return NavigationHomeScreen();
              // return SearchedContacts();
            }
            if (state is AuthenticationUnauthenticated) {
              // return RelationScreen();
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return Text("something wrong");
          },
        ),
      ),
    );
  }
}
