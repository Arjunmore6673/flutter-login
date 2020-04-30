import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';
import 'package:flutterapp/screens/common/CircleAvtarCommon.dart';
import 'package:flutterapp/screens/common/ProfileImgAndDetailsCommon.dart';
import 'package:flutterapp/screens/common/TextCommon.dart';
import 'package:flutterapp/screens/common/loading.dart';
import 'package:flutterapp/util/constants.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProfile extends StatefulWidget {
  final RelationModel model;
  ViewProfile({Key key, @required this.model}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  File _image;
  String _uploadedFileURL;
  bool isLoading = false;
  RelationModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    _uploadedFileURL = widget.model.image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => RelationBloc(
            UserRepository(),
          )..add(RelationListPressed(userId: widget.model.id)),
          child: getProfileWidget(),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getProfileWidget() {
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImageContainer(),
            TextCommon(
              text: widget.model.name,
              fontSize: 30,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 35.0,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Text('Call', style: TextStyle(color: Colors.black)),
                        SizedBox(width: 10),
                        Icon(Icons.call),
                      ],
                    ),
                    onPressed: () => setState(() {
                      _makePhoneCall('tel:$model.mobile');
                    }),
                  ),
                ),
                Container(
                  height: 35.0,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.message),
                        SizedBox(width: 10),
                        Text('Message', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20.0),

        UserInfo(
          model: model,
        ),
        // Container(
        //   child: BlocBuilder<RelationBloc, RelationState>(
        //     builder: (context, state) {
        //       if (state is RelationLoadingState) {
        //         return Center(child: CircularProgressCommon());
        //       }
        //       if (state is RelationLoadFailureState) {
        //         return Text("error..");
        //       }
        //       if (state is RelationLoadedState) {
        //         return geHisRelatives(state.data);
        //       }
        //       return Text("initial ");
        //     },
        //   ),
        // )
      ],
    );
  }

  getImageContainer() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _uploadedFileURL == null || _uploadedFileURL == ""
                    ? CircleAvatarCommon(
                        assetImage: true,
                        url: (model.name == 'MALE'
                            ? 'assets/men.jpg'
                            : 'assets/women.jpg'),
                      )
                    : CircleAvatarCommon(
                        assetImage: true,
                        url: _uploadedFileURL,
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
                isLoading ? CircularProgressCommon() : SizedBox()
              ],
            ),
          ),
        )
      ],
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      _image = image;
      uploadFile();
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      print(fileURL);
      setState(() {
        _uploadedFileURL = fileURL;
        isLoading = false;
      });
      saveImageUrl(fileURL);
    });
  }

  saveImageUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.TOKEN);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Token " + token
    };
    Response response = await http.put(
      Constants.BASE_URL + "/api/secured/update_user_image",
      headers: headers,
      body: json.encode({"url": url, "userId": model.id}),
    );
    final res = json.decode(response.body);
    final userData = res["data"];
    print("successfully updated" + userData.toString());
  }

  Widget geHisRelatives(Map<String, Object> data) {
    List<RelationModel> mamaMami = data["mamaMami"];
    List<RelationModel> kakaMavshi = data["kakaMavshi"];
    List<RelationModel> broSis = data["broSis"];
    List<RelationModel> other = data["other"];
    List<RelationModel> total = [];
    total.addAll(mamaMami);
    total.addAll(kakaMavshi);
    total.addAll(broSis);
    total.addAll(other);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: total.length,
      itemBuilder: (BuildContext context, int index) {
        return ProfileImgAndDetails(
          userModel: total[index],
          onPress: () {
            onPressFunction(context, total[index]);
          },
        );
      },
    );
  }

  onPressFunction(BuildContext context, RelationModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewProfile(model: model)),
    );
  }
}

class UserInfo extends StatelessWidget {
  final RelationModel model;
  UserInfo({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 1),
                            leading: Icon(Icons.person),
                            title: Text("Relation"),
                            subtitle: Text(model.relation,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Location"),
                            subtitle: Text(model.getMobile),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle:
                                Text(model.email != null ? model.email : ""),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Phone"),
                            subtitle: Text(model.mobile),
                          ),
                          // ListTile(
                          //   leading: Icon(Icons.person),
                          //   title: Text("About Me"),
                          //   subtitle: Text(""),
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
