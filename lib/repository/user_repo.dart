import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/util/constants.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  //final baseUrl = "https://natigunta6673.herokuapp.com"; //

  Map<String, String> headers = {
    "Content-type": "application/json",
    "Authorization":
        "Token eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJyb2NrYWptQGdtYWlsLmNvbSIsImlkIjoiMSIsInN0YXR1cyI6IkFDVElWRSJ9.GU5IBNjd2Ry57h7Ywr9ZacVNlCFFAKJcedpsP0KIgMtHc51-OOgOIIada_u5UVAtElrs_0DPnF1YtQcxaPzsNg"
  };

  Future<String> registerUser(RegistrationModel model) async {
    // RegistrationModel model  = new RegistrationModel("ARJUN", "31311331", "rock@gmail.com", "12345", "MALE", "15/01/1196", "pUNE");
    // await Future.delayed(Duration(seconds: 1));
    String uid = await createFirebaseUIDforUser(model.name);
    print(uid);
    if (uid == "") {
      print("nulll id firebase");
      return null;
    }
    Response response = await http.post(
      Constants.BASE_URL + "/auth/register",
      headers: headers,
      body: json.encode({
        "email": model.email,
        "mobile": model.mobile,
        "password": model.password,
        "name": model.name,
        "gender": model.gender,
        "dob": "2012-09-15",
        "address": model.address,
        "firebaseId": uid
      }),
    );
    final res = json.decode(response.body);
    final userData = res["data"];

    return userData.toString();
  }

  Future<String> createFirebaseUIDforUser(String name) async {
    var ref = Firestore.instance.collection('users').document();
    var idBefore = ref.documentID;
    print(idBefore); // prints the unique id
    String result = "";
    await ref.setData({
      'nickname': name,
      'id': idBefore,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'chattingWith': null
    }).then((_) {
      result = idBefore;
    }).catchError((onError) {
      print("FAILed " + onError.toString());
      result = "";
    });
    return result;
  }

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    // await Future.delayed(Duration(seconds: 1));
    Response response = await http.post(
      Constants.BASE_URL + "/auth/login",
      headers: headers,
      body: json.encode({"username": username, "password": password}),
    );
    final res = json.decode(response.body);
    final userData = res["user"];
    final da = RelationModel.fromJson(userData);
    print("------------");
    print(res.toString());
    await _saveUserData(da);
    final token = res["token"];
    return token;
  }

  Future<String> addRelation(
      {@required String name,
      @required String mobile,
      @required String email,
      @required String image,
      @required String gender,
      @required String address,
      @required String relation,
      @required String avtar}) async {
    /// token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.TOKEN);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Token " + token
    };
    //uid Firebase
    String uid = await createFirebaseUIDforUser(name);

    String output = mobile.replaceAll(' ', '');
    String outputRemovedDash = output.replaceAll('-', '');
    var mobileFinal =
        outputRemovedDash.substring(outputRemovedDash.length - 10);
    // await Future.delayed(Duration(seconds: 1));
    Response response = await http.post(
      Constants.BASE_URL + "/api/secured/add_relation_user",
      headers: headers,
      body: json.encode(
        {
          "user": {
            "name": name,
            "mobile": mobileFinal,
            "gender": gender,
            "image": image,
            "email": '',
            "city": address,
            "firebaseId":uid,
            "status":"ADDED"
          },
          "relation": relation,
        },
      ),
    );
    final res = json.decode(response.body);
    print("----------------");
    print(res);
    print("----------------");
    return 'token';
  }

  /// get relation list of user
  Future<Map<String, Object>> getRelationList({@required int userId}) async {
    String url = Constants.BASE_URL +
        "/api/secured/get_nested${userId == -1 ? '' : "?userId=${userId.toString()}"}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.TOKEN);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Token " + token
    };

    Response response = await http.get(url, headers: headers);
    final res = json.decode(response.body);
    print(res);
    final data = res["data"] as List;
    List<RelationModel> model =
        data.map((m) => RelationModel.fromJson2(m)).toList();
    return await getFiteredList(model);
  }

  Future<Map<String, Object>> getFiteredList(List<RelationModel> model) async {
    print(model.length.toString() + "__");
    Map<String, Object> map = new Map();
    List<RelationModel> mamaMami = [];
    List<RelationModel> kakaMavshi = [];
    List<RelationModel> broSis = [];
    List<RelationModel> daji = [];
    List<RelationModel> other = [];
    model.forEach((obj) => {
          if (obj.getRelation == null)
            {other.add(obj)}
          else if (obj.getRelation == "MAMA" || obj.getRelation == "MAMI")
            {mamaMami.add(obj)}
          else if (obj.getRelation == "KAKA" || obj.getRelation == "MAVSHI")
            {kakaMavshi.add(obj)}
          else if (obj.getRelation.contains("BROTHER") ||
              obj.getRelation.contains('SISTER'))
            {broSis.add(obj)}
          else if (obj.getRelation == "DAJI")
            {daji.add(obj)}
          else
            {other.add(obj)}
        });

    map["mamaMami"] = mamaMami;
    map["kakaMavshi"] = kakaMavshi;
    map["broSis"] = broSis;
    map["daji"] = daji;
    map["other"] = other;
    return map;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.TOKEN, token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 1));
    String token = prefs.getString(Constants.TOKEN);
    print(token);
    if (token != null && token.length > 10)
      return true;
    else
      return false;
  }

  Future<void> _saveUserData(RelationModel da) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.USER_ID, da.getId);
    await prefs.setString(Constants.USER_NAME, da.getName);
    await prefs.setString(Constants.USER_MOBILE, da.getMobile);
    await prefs.setString(Constants.USER_EMAIL, da.getEmail);
    await prefs.setString(Constants.USER_GENDER, da.getGender);
    await prefs.setString(Constants.USER_RELATION, da.getRelation);
    await prefs.setString(Constants.USER_IMAGE, da.getImage);
    await prefs.setString(Constants.USER_ADDRESS, da.getAddress);
    await prefs.setString(Constants.USER_DOB, da.dob);
    await prefs.setString(Constants.USER_FIREBASE_ID, da.firebaseId);
  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return RelationModel(
      prefs.getInt(Constants.USER_ID),
      prefs.getString(Constants.USER_MOBILE),
      prefs.getString(Constants.USER_NAME),
      prefs.getString(Constants.USER_EMAIL),
      prefs.getString(Constants.USER_GENDER),
      prefs.getString(Constants.USER_RELATION),
      prefs.getString(Constants.USER_IMAGE),
      prefs.getString(Constants.USER_ADDRESS),
      prefs.getString(Constants.USER_DOB),
      prefs.getString(Constants.USER_FIREBASE_ID),
    );
  }

  getContactList() async {
    if (await Permission.contacts.isGranted) {
      print("granted");
      List<Contact> contactsAll =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
      var cc = contactsAll
          .where(
            (i) =>
                regularExpression(i.displayName, 'mami') ||
                regularExpression(i.displayName, 'kaka') ||
                regularExpression(i.displayName, 'mavshi') ||
                regularExpression(i.displayName, 'mama') ||
                regularExpression(i.displayName, 'sister') ||
                regularExpression(i.displayName, 'bro') ||
                regularExpression(i.displayName, 'brother') ||
                regularExpression(i.displayName, 'siso') ||
                regularExpression(i.displayName, 'didi'),
          )
          .toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> listDeleted = prefs.getStringList("DELETED");
      if (listDeleted == null) {
        listDeleted = [];
      }
      var filterredList =
          cc.where((test) => !listDeleted.contains(test.displayName)).toList();
      return filterredList;
    } else {
      print("he dont have persmission");
    }
  }

  bool regularExpression(String stringg, String search) {
    RegExp exp = new RegExp(
      "\\b" + search + "\\b",
      caseSensitive: false,
    );
    return exp.hasMatch(stringg);
  }

  getContactListAvtar(contactList) async {
    List<Contact> contactWithAvtar = [];
    // Lazy load thumbnails after rendering initial contacts.
    for (final contact in contactList) {
      ContactsService.getAvatar(contact).then((avatar) {
        contact.avatar = avatar;
        contactWithAvtar.add(contact);
      });
    }
    return contactWithAvtar;
  }

  Future<String> uploadFile(File image) async {
    try {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      return await storageReference.getDownloadURL();
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> updateUserDeatils(RelationModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.TOKEN);
    var id = prefs.getInt(Constants.USER_ID);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Token " + token
    };
    Response response = await http.put(
      Constants.BASE_URL + "/api/secured/update_user",
      headers: headers,
      body: json.encode({
        "id": id,
        "image": model.image,
        "name": model.name,
        "address": model.address,
        "dob": model.dob,
        "gender": model.gender,
        "email": model.email,
        "mobile": model.mobile,
      }),
    );
    final res = json.decode(response.body);
    final userData = res["data"];
    final data = RelationModel.fromJson(userData);
    _saveUserData(data);
    print("successfully updated" + userData.toString());
  }
}
