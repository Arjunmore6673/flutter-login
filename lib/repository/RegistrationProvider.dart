import 'dart:async';
import 'dart:convert';
import 'package:flutterapp/model/RegistrationModel.dart';
import 'package:http/http.dart' as http;

class RegistrationProvider {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  final msg = jsonEncode({"grant_type":"password","username":"******","password":"*****","scope":"offline_access"});

  Future<int> saveRegistration(RegistrationModel model) async {
    print("api called");
    return http
        .post("http://192.168.43.89:8001/auth/register",
            headers: headers, body: json.encode(model.toMap()))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return statusCode;
    });
  }
//
//  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
//    final response = await http
//        .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");
//    print(response.body.toString());
//    if (response.statusCode == 200) {
//      return MovieDetailModel.fromJson(json.decode(response.body));
//    } else {
//      throw Exception('Failed to load post');
//    }
//  }
//
//  Future<MovieImageModel> fetchMovieImages(int movieId) async {
//    final response = await client.get(
//        "http://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey");
//    print(response.body.toString());
//    if (response.statusCode == 200) {
//      return MovieImageModel.fromJson(json.decode(response.body));
//    } else {
//      throw Exception('Failed to load post');
//    }
//  }
}
