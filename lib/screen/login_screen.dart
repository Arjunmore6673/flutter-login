
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/navigation_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginScreenState extends State<LoginScreen> {

 String _validatePassword(String value) {
   if (value.length < 8) {
     return 'The Password must be at least 8 characters.';
   }
   return null;
 }

 String _validateEmail(String value) {

   if(!(value.length>0 && value.contains("@") && value.contains("."))){
   return 'The E-mail Address must be a valid email address.';
   }
   return null;
 }


 void _submit() {
//   NavigationRouter.switchToLogin(context);
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

    final Size screenSize = media.size;
    return new Scaffold(
      //key: this.scaffoldKey,
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),

          child: new Form(
            child: new ListView(
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    child:new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlutterLogo(
                        size: 100.0,
                      ),
                    ],
                  )
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                      keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address',
                          icon: new Icon(Icons.email)),
                      validator: this._validateEmail,

                      )
                  ),
                new Container(
                  padding: const EdgeInsets.only(top:10.0),
                  child:  new TextFormField(
                      obscureText: true, // Use secure text for passwords.
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          icon: new Icon(Icons.lock)

                      ),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                      }
                  ),
                ),
                new Container(
                  width: screenSize.width,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height:50.0,
                        margin: const EdgeInsets.only(left: 10.0,top: 30.0),
                        child: new RaisedButton(
                          child: new Text(
                            'Login',
                            style: new TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: this._submit,
                          color: Colors.deepPurple,
                        ),

                      ),
                      new Container(
                        height:50.0,
                        margin: const EdgeInsets.only(left: 20.0,top: 30.0),
                        child: new RaisedButton(
                          child: new Text(
                            'Registration',
                            style: new TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: _navigateRegistration,
                          color: Colors.deepPurple,
                        ),

                      )
                    ],
                  ),
                ),
                new Container(
                  width: screenSize.width,
                    child:new Column(
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(left: 10.0,top: 20.0),
                          child:    new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height:50.0,
                                width: 210.0,
                                child: new RaisedButton.icon(
                                  label: new Text(
                                    'Login with Google+',
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  icon: new Image.asset("assets/google_plus.png",width: 24.0,height: 24.0),
                                  color: Colors.red,

                                ),

                              ),

                            ],
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(left: 10.0,top: 20.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height:50.0,
                                width: 210.0,
                                child: new RaisedButton.icon(
                                  label: new Text(
                                    'Login with Facebook',
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                 icon: new Image.asset("assets/facebook.png",width: 24.0,height: 24.0,),
                                 // icon: const Icon(Icons.adjust, size: 28.0,color: Colors.white),
                                  color: Colors.indigo,
                                ),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                )



              ],
            ),
          )
      ),
    );
  }


  _navigateRegistration() {
    NavigationRouter.switchToRegistration(context);
  }

}
