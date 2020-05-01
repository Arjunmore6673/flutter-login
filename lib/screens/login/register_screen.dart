import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_event.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_state.dart'
    as StateProfile;
import 'package:flutterapp/blocs/profile_bloc/profile_state.dart';
import 'package:flutterapp/blocs/registration_bloc/register_bloc.dart';
import 'package:flutterapp/blocs/registration_bloc/register_event.dart';
import 'package:flutterapp/blocs/registration_bloc/register_state.dart';
import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/CommonIconButton.dart';
import 'package:flutterapp/screens/common/loading.dart';
import 'package:flutterapp/screens/common/navigator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              RegistrationBloc(userRepository: userRepository),
          child: RegisterForm(context),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              ProfileBloc(userRepository: userRepository),
        ),
      ],
      child: RegisterForm(context),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final BuildContext contextScreen;

  RegisterForm(this.contextScreen);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNoController = TextEditingController();
  String radioItem = '';
  RegistrationBloc _registerBloc;

  bool isLoading = false;
  String downloadUrl = "";
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegistrationBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  saveRegistration(RegistrationModel model, BuildContext context) async {
    Nevigator.navigateToLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: BlocListener<RegistrationBloc, RegisterState>(
          /// listener to listen failure events
          listener: (contextListener, state) {
            if (state is RegistrationSuccessfully) {
              AlertDialog alert = AlertDialog(
                title: Text("Registration"),
                content: Text('Registration done Successfully'),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(widget.contextScreen);
                      Navigator.pop(context);
                    },
                  )
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
            if (state is RegistrationError) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Registration Failed"),
                  content: Text("SOmething Went WRong..Try again Later"),
                ),
              );
            }
          },

          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getImageContainer(),
                  name(),
                  emailField(),
                  village(),
                  gender(),
                  mobile(),
                  passwordField(),
                  passwordField2(),
                  Builder(
                    builder: (BuildContext context) {
                      return Center(
                        child: CommonIconButton(
                          buttonText: "Register",
                          color: Colors.white,
                          onTap: () {
                            String msg = validateAndRegisterUser();
                            if (msg != "success") {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(msg),
                              ));
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void chooseFile(BuildContext context) async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      _profileBloc.add(UploadImageToFirebase(url: image));
    });
  }

  getImageContainer() {
    return Stack(
      children: <Widget>[
        BlocBuilder<ProfileBloc, StateProfile.ProfileState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        state is UploadedImage
                            ? getAvtar(state)
                            : CircleAvatarCommon(
                                assetImage: true,
                                url: ('assets/images/place.jpg'),
                              ),
                        Positioned(
                          bottom: -25,
                          left: 50,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                chooseFile(context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            ),
                          ),
                        ),
                        state is StateProfile.Loading
                            ? CircularProgressCommon()
                            : SizedBox()
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }

  getAvtar(UploadedImage state) {
    downloadUrl = state.downloadUrl;
    return CircleAvatarCommon(
      redius: 60,
      url: state.downloadUrl,
    );
  }

  Widget name() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: "Full name",
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: _emailController,
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
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        labelText: "State, city, village",
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget mobile() {
    return TextFormField(
      controller: _mobileNoController,
      decoration: InputDecoration(
        labelText: "Mobile number",
      ),
      keyboardType: TextInputType.phone,
    );
  }

  String validateAndRegisterUser() {
    if (_nameController.text.length <= 0) {
      return "Please enter full name";
    }
    if (_passwordController.text != _passwordController2.text) {
      return "password not matching";
    }
    if (_addressController.text.length <= 0) {
      return "Please add address";
    }
    if (_mobileNoController.text.length <= 0) {
      return "Please enter mobile number";
    }
    if (radioItem == '') {
      return "Please select gender";
    }

    _registerBloc.add(
      RegisterButtonPressed(
        model: new RegistrationModel(
          _nameController.value.text,
          _mobileNoController.value.text,
          _emailController.value.text,
          _passwordController.value.text,
          radioItem,
          "1996-01-15",
          _addressController.value.text,
          downloadUrl,
        ),
      ),
    );
    return "success";
  }
}
