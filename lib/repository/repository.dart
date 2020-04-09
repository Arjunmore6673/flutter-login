import 'dart:async';

import 'package:flutterapp/model/RegistrationModel.dart';
import 'RegistrationProvider.dart';

class Repository {
  final moviesApiProvider = RegistrationProvider();

//
//  Future<MovieDetailModel> fetchMovieDetail(int movieId) => moviesApiProvider.fetchMovieDetail(movieId);
//
//  Future<MovieImageModel> fetchMovieImages(int movieId) => moviesApiProvider.fetchMovieImages(movieId);
//
//  Future<ItemModel> fetchMovieList(String type) => moviesApiProvider.fetchMovieList(type);
//
  Future<int> submitRegistration(RegistrationModel model) =>
      moviesApiProvider.saveRegistration(model);
}
