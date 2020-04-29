import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_event.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/loading.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = new UserRepository();
    return Container(
      child: BlocProvider<ProfileBloc>(
        create: (context) {
          return ProfileBloc(userRepository: userRepository)
            ..add(
              GetUserDetails(),
            );
        },
        child: ProfilePage(),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool isLoading = false;
  String downloadUrl = "";
  RelationModel modelMy;
  ProfileBloc _profileBloc;

  /// form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _aboutMeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _nameController.text = "arjun";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25.0),
                                child: Text('PROFILE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        fontFamily: 'sans-serif-light',
                                        color: Colors.black)),
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: getImageContainer())
                    ],
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is UserRetrivedDetails) {
                      modelMy = state.model;
                      _nameController.text = modelMy.getName;
                      _addressController.text = modelMy.address;
                      _mobileController.text = modelMy.mobile;
                      _dobController.text = modelMy.dob;
                      _emailController.text = modelMy.email;
                      return formAllInputs();
                    }
                    return formAllInputs();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget formAllInputs() {
    return Container(
      color: Color(0xffFFFFFF),

      /// adding listernr for update listen
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is SavedProfile) {
            Scaffold.of(context)
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Updated Successfully'), Icon(Icons.done)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Parsonal Information',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _status ? _getEditIcon() : Container(),
                        ],
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Name",
                          ),
                          enabled: !_status,
                          autofocus: !_status,
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Email ID',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          enabled: false,
                          controller: _emailController,
                          decoration:
                              const InputDecoration(hintText: "Enter Email ID"),
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Mobile',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _mobileController,
                          decoration: const InputDecoration(
                              hintText: "Enter Mobile Number"),
                          enabled: false,
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Text(
                    'City / Village',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Village or City name"),
                  enabled: !_status,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Text(
                    'About me',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: TextField(
                  controller: _aboutMeController,
                  decoration: const InputDecoration(hintText: "About me.. "),
                  enabled: !_status,
                ),
              ),
              !_status ? _getActionButtons() : Container(),
            ],
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
    String genderTemp = "MALE";
    return Stack(
      children: <Widget>[
        BlocBuilder<ProfileBloc, ProfileState>(
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
                                url: (genderTemp == 'MALE'
                                    ? 'assets/men.jpg'
                                    : 'assets/women.jpg'),
                              ),
                        Positioned(
                          bottom: -25,
                          left: 60,
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
                        state is Loading
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

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  getAvtar(UploadedImage state) {
    downloadUrl = state.downloadUrl;
    return CircleAvatarCommon(
      redius: 60,
      url: state.downloadUrl,
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                      child: RaisedButton(
                    child: Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      RelationModel model = new RelationModel(
                          1,
                          _mobileController.value.text,
                          _nameController.value.text,
                          _emailController.value.text,
                          modelMy.gender,
                          "",
                          downloadUrl,
                          _addressController.value.text,
                          modelMy.dob,
                          modelMy.firebaseId);
                      _profileBloc.add(SaveProfileEvent(model));

                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  )),
                ),
                flex: 2,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                      child: RaisedButton(
                    child: Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  )),
                ),
                flex: 2,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
