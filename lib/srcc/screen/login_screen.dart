import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              child: Column(
                children: <Widget>[
                  emailField(),
                  passwordField(),
                  raisedButton(),
                ],
              ),
            ),
          )
        )
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email address",
        hintText: "rockajm@gmail.com",
      ),
      validator: (value) {
        if (!value.contains('@'))
          return "Please enter email";
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
      ),
      keyboardType: TextInputType.text,
    );
  }


  Widget raisedButton() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
        child: Text("Submit"),
        color: Colors.white,
        onPressed: () {},
      ),
    );
  }
}
