import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/auth_bloc/auth_state.dart';
import 'package:flutterapp/blocs/bloc_login/login_bloc.dart';
import 'package:flutterapp/blocs/bloc_login/login_event.dart';
import 'package:flutterapp/blocs/bloc_login/login_state.dart';
import 'package:flutterapp/screens/common/navigator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }

  String _validateEmail(String value) {
    if (!(value.length > 0 && value.contains("@") && value.contains("."))) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

/* void _performLogin() {
   // This is just a demo, so no actual login here.
   final snackbar = new SnackBar(
     content: new Text('Email: $_email, password: $_password'),
   );

   scaffoldKey.currentState.showSnackBar(snackbar);
 }*/
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    var emailControl = TextEditingController();
    var passControl = TextEditingController();

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: emailControl.text,
          password: passControl.text,
        ),
      );
    }

    final Size screenSize = media.size;
    return Container(
      padding: EdgeInsets.all(20.0),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Nevigator.navigateNavigationHomePage(context);
            }
            return Form(
              child: ListView(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlutterLogo(
                            size: 100.0,
                          ),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailControl,
                        // Use email input type for emails.
                        decoration: InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address',
                            icon: new Icon(Icons.email)),
                        validator: this._validateEmail,
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                        obscureText: true,
                        // Use secure text for passwords.
                        controller: passControl,
                        decoration: new InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter your password',
                            icon: new Icon(Icons.lock)),
                        validator: this._validatePassword,
                        onSaved: (String value) {}),
                  ),
                  Container(
                    width: screenSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          margin: const EdgeInsets.only(left: 10.0, top: 30.0),
                          child: RaisedButton(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: state is! LoginLoading
                                ? _onLoginButtonPressed
                                : null,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Container(
                          height: 50.0,
                          margin: const EdgeInsets.only(left: 20.0, top: 30.0),
                          child: RaisedButton(
                            child: Text(
                              'Registration',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Nevigator.navigateRegisterPage(context);
                            },
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

// //                new Container(
// //                  width: screenSize.width,
// //                  child:new Column(
// //                    children: <Widget>[
// //                      new Container(
// //                        margin: const EdgeInsets.only(left: 10.0,top: 20.0),
// //                        child:    new Row(
// //                          mainAxisAlignment: MainAxisAlignment.center,
// //                          children: <Widget>[
// //                            new Container(
// //                              height:50.0,
// //                              width: 210.0,
// //                              child: new RaisedButton.icon(
// //                                label: new Text(
// //                                  'Login with Google+',
// //                                  style: new TextStyle(
// //                                    color: Colors.white,
// //                                  ),
// //                                ),
// //                                icon: new Image.asset("assets/google_plus.png",width: 24.0,height: 24.0),
// //                                color: Colors.red,
// //
// //                              ),
// //
// //                            ),
// //
// //                          ],
// //                        ),
// //                      ),
// //                      new Container(
// //                        margin: const EdgeInsets.only(left: 10.0,top: 20.0),
// //                        child: new Row(
// //                          mainAxisAlignment: MainAxisAlignment.center,
// //                          children: <Widget>[
// //                            new Container(
// //                              height:50.0,
// //                              width: 210.0,
// //                              child: new RaisedButton.icon(
// //                                label: new Text(
// //                                  'Login with Facebook',
// //                                  style: new TextStyle(
// //                                    color: Colors.white,
// //                                  ),
// //                                ),
// //                                icon: new Image.asset("assets/facebook.png",width: 24.0,height: 24.0,),
// //                                // icon: const Icon(Icons.adjust, size: 28.0,color: Colors.white),
// //                                color: Colors.indigo,
// //                              ),
// //
// //                            ),
// //
// //                          ],
// //                        ),
// //                      )
// //                    ],
// //                  ),
// //                )
}
