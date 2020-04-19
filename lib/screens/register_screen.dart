import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/blocs/registration_bloc.dart';
import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/navigator.dart';
import 'package:flutterapp/screens/login_page.dart';
import 'package:flutterapp/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNoController = TextEditingController();
  String radioItem = '';
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Authorization":
        "Token eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJyb2NrYWptQGdtYWlsLmNvbSIsImlkIjoiMSIsInN0YXR1cyI6IkFDVElWRSJ9.GU5IBNjd2Ry57h7Ywr9ZacVNlCFFAKJcedpsP0KIgMtHc51-OOgOIIada_u5UVAtElrs_0DPnF1YtQcxaPzsNg"
  };

  saveRegistration(RegistrationModel model, BuildContext context) async {
    Response response = await http.post(
      Constants.BASE_URL + "/auth/register",
      headers: headers,
      body: json.encode(model.toMap()),
    );
    final res = json.decode(response.body);
    final userData = res["data"];
    print("success" + userData.toString());
    Nevigator.navigateToLoginPage(context);
    showError("Registered successfully");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: registrationBloc.registrationResponse,
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 200) {
            return LoginPage(
              userRepository: UserRepository(),
            );
          } else {
            return Text("som  ething fuckied ");
          }
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey, // you missed out on this!!!
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      name(),
                      emailField(),
                      village(),
                      gender(),
                      mobile(),
                      passwordField(),
                      passwordField2(),
                      raisedButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget name() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: "Full name",
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.text,
        );
      },
    );
  }

  Widget emailField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "Email address",
            hintText: "rockajm@gmail.com",
            errorText: snapshot.error,
          ),
          validator: (value) {
            if (!value.contains('@'))
              return "Please enter email";
            else
              return null;
          },
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }

  Widget gender() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RadioListTile(
            groupValue: radioItem,
            title: Text(
              'MALE',
              textAlign: TextAlign.left,
            ),
            value: 'MALE',
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            groupValue: radioItem,
            title: Text('Female'),
            value: 'FEMALE',
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget passwordField() {
    return TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "password",
        ),
        validator: (value) {
          if (value.length < 5)
            return "Please enter valid password";
          else
            return null;
        },
        keyboardType: TextInputType.visiblePassword);
  }

  Widget passwordField2() {
    return TextFormField(
        controller: _passwordController2,
        decoration: InputDecoration(
          labelText: "confirm password",
        ),
        validator: (value) {
          if (value.length < 5)
            return "Please enter valid password";
          else
            return null;
        },
        keyboardType: TextInputType.visiblePassword);
  }

  Widget village() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            labelText: "State, city, village",
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.text,
        );
      },
    );
  }

  Widget mobile() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          controller: _mobileNoController,
          decoration: InputDecoration(
            labelText: "Mobile number",
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.phone,
        );
      },
    );
  }

  Widget raisedButton() {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: RaisedButton(
        elevation: 8,
        child: Text("Register"),
        color: Colors.white,
        onPressed: validateAndRegisterUser,
      ),
    );
  }

  showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  validateAndRegisterUser() {
    if (_nameController.text.length <= 0) {
      showError("Please enter full name");
      return;
    }
    if (_passwordController.text != _passwordController2.text) {
      showError("password not matching");
      return;
    }
    if (_addressController.text.length <= 0) {
      showError("Please add address");
      return;
    }
    if (_mobileNoController.text.length <= 0) {
      showError("Please enter mobile number");
      return;
    }
    if (radioItem == '') {
      showError("Please select gender");
      return;
    }

    {
      saveRegistration(
          new RegistrationModel(
            _nameController.text,
            _mobileNoController.text,
            _emailController.text,
            _passwordController.text,
            radioItem,
            "1996-01-15",
            _addressController.text,
          ),
          context);
    }
  }
}
