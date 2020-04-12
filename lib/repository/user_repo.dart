import 'package:flutterapp/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UserRepository {
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Authorization":
        "Token eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJyb2NrQGdtYWlsLmNvbSIsImlkIjoiOCIsInN0YXR1cyI6IkFDVElWRSJ9.J55PM4eS7_AZAmcduFahZN146l_Srv03YP7TUb1HZVgPjFfXIPdrvbRWSOAe33dF5U_rrwD2f3NyoeMlHTVE6Q",
  };

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    // await Future.delayed(Duration(seconds: 1));
    Response response = await http.post(
      "http://192.168.43.89:8001/auth/login",
      headers: headers,
      body: json.encode(
        {"username": "rock@gmail.com", "password": "12345"},
      ),
    );
    final res = json.decode(response.body);
    final userData = res["user"];
    final da = RelationModel.fromJson(userData);
    _saveUserData(da);
    final token = res["token"];
    return token;
  }

  Future<String> add_relation({
    @required String name,
    @required String mobile,
    @required String address,
    @required String relation,
  }) async {
    // await Future.delayed(Duration(seconds: 1));
    Response response = await http.post(
      "http://192.168.43.89:8001/api/secured/add_relation",
      headers: headers,
      body: json.encode(
        {
          "name": name,
          "mobile": mobile,
          "address": address,
          "relation": relation
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
    Response response = await http.get(
      "http://192.168.43.89:8001/api/secured/get_nested",
      headers: headers,
    );
    final res = json.decode(response.body);
    final data = res["data"] as List;
    List<RelationModel> model =
        data.map((m) => RelationModel.fromJson2(m)).toList();
    return await getFiteredList(model);
  }

  Future<Map<String, Object>> getFiteredList(List<RelationModel> model) async {
    Map<String, Object> map = new Map();
    List<RelationModel> mamaMami = [];
    List<RelationModel> kakaMavshi = [];
    List<RelationModel> broSis = [];
    List<RelationModel> daji = [];
    List<RelationModel> other = [];
    model.forEach((obj) => {
          if (obj.getRelation == "MAMA" || obj.getRelation == "MAMI")
            {mamaMami.add(obj)}
          else if (obj.getRelation == "KAKA" || obj.getRelation == "MAVSHI")
            {kakaMavshi.add(obj)}
          else if (obj.getRelation == "BROTHER" || obj.getRelation == 'SISTER')
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
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
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
    await prefs.setString(Constants.USER_RELATION, da.getRelation);
    await prefs.setString(Constants.USER_IMAGE, da.getImage);
  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return RelationModel(
      prefs.getInt(Constants.USER_ID),
      prefs.getString(Constants.USER_MOBILE),
      prefs.getString(Constants.USER_NAME),
      prefs.getString(Constants.USER_EMAIL),
      prefs.getString(Constants.USER_RELATION),
      prefs.getString(Constants.USER_IMAGE),
    );
  }
}
