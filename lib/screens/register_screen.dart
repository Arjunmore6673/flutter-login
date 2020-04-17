import 'package:flutter/material.dart';
import 'package:flutterapp/blocs/registration_bloc.dart';
import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/feedback_screen.dart';
import 'package:flutterapp/screens/login_page.dart';
import 'package:flutterapp/screens/login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: registrationBloc.registrationResponse,
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 200) {
              return LoginPage(userRepository: UserRepository(),);
            } else {
              return Text("som  ething fuckied ");
            }
          }
          return Container(
            child: Card(
                child: Padding(
              child: Form(
                key: formKey, // you missed out on this!!!
                child: Column(
                  children: <Widget>[
                    name(),
                    emailField(),
                    passwordField(),
                    passwordField2(),
                    village(),
                    mobile(),
                    raisedButton(),
                  ],
                ),
              ),
              padding: EdgeInsets.all(20),
            )),
          );
        });
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
          keyboardType: TextInputType.phone,
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
          keyboardType: TextInputType.phone,
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
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
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

    {
      registrationBloc.saveRegistration(new RegistrationModel(
          _addressController.text,
          _mobileNoController.text,
          _emailController.text,
          _passwordController.text,
          "male",
          "1996-01-15",
          _addressController.text,
          "c",
          "state",
          "country",
          "3"));
    }
  }
}
