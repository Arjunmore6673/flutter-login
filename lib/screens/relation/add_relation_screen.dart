
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_event.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_state.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/loading.dart';
import 'package:image_picker/image_picker.dart';

class AddRelation extends StatefulWidget {
  AddRelation({Key key}) : super(key: key);

  @override
  _AddRelationState createState() => _AddRelationState();
}

class _AddRelationState extends State<AddRelation> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _addressController = TextEditingController();
  String relationSelected = "Select Relation";
  String radioItem = '';
  String downloadUrl = "";

  bool isLoading = false;
  RelationBloc relationBloc;
  ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    relationBloc = BlocProvider.of<RelationBloc>(context);
  }

  @override
  void dispose() {
    relationBloc.close();
    profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 80,
      child: Container(
        margin: EdgeInsets.all(10),
        child: BlocListener<RelationBloc, RelationState>(
          listener: (context, state) {
            if (state is RelationAddedState) {
              AlertDialog alert = AlertDialog(
                title: Text("My title"),
                content: Text('aDDED sUCCESSfullY'),
                actions: [],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
            if (state is RelationLoadFailureState) {
              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("My title"),
                content: Text('sOMTHING FuCKED.?>' + state.error),
                actions: [],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            margin: EdgeInsets.all(0),
            child: Form(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getImageContainer(),
                    name(),
                    gender(),
                    mobile(),
                    emailField(),
                    address(),
                    SizedBox(height: 10),
                    relationDropDown(),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        child: Text("Save"),
                        elevation: 8,
                        color: Colors.white,
                        onPressed: () {
                          BlocProvider.of<RelationBloc>(context).add(
                              RelationAddPressed(
                                  name: _nameController.value.text,
                                  mobile: _mobileNoController.value.text,
                                  image: downloadUrl,
                                  gender: radioItem,
                                  email: _emailController.value.text,
                                  address: _addressController.value.text,
                                  relation: relationSelected));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      profileBloc.add(UploadImageToFirebase(url: image));
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
                                redius: 50,
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
                              onTap: chooseFile,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            ),
                          ),
                        ),
                        state is Loading ? CircularProgressCommon() : SizedBox()
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
      redius: 50,
      url: state.downloadUrl,
    );
  }

  Widget relationDropDown() {
    List<String> data = [
      'Select Relation',
      'MAMA',
      'MAMI',
      'KAKA',
      'MAVSHI',
      'MOTHER',
    ];

    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        hint: Text("Select Relation"),
        isExpanded: true,
        value: relationSelected,
        items: data.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            relationSelected = value;
          });
        },
      ),
    );
  }

  Widget address() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        labelText: "Address",
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget name() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        errorText: "",
      ),
      controller: _nameController,
      keyboardType: TextInputType.text,
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

  Widget emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email address",
        hintText: "rockajm@gmail.com",
        errorText: "",
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

  Widget mobile() {
    return TextFormField(
      controller: _mobileNoController,
      decoration: InputDecoration(
        labelText: "Mobile number",
        errorText: "",
      ),
      keyboardType: TextInputType.text,
    );
  }
}
