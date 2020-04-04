import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              state(),
              city(),
              village(),
              mobile(),
              raisedButton(),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
      )),
    );
  }

  Widget state() {
    return DropdownButton<String>(
      hint: Text("Select State"),
      isExpanded: true,
      items: <String>['Maharashtra', 'goa'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget city() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text("Select City"),
      items: <String>['pune', 'satara', 'mumbai'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget village() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Village",
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.phone,
        );
      },
    );
  }

  Widget name() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
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

  Widget mobile() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Mobile number",
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.phone,
        );
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
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

  Widget raisedButton() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
        child: Text("Register"),
        color: Colors.white,
        onPressed: () {
          formKey.currentState.validate();
        },
      ),
    );
  }
}
