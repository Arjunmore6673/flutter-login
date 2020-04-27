import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutterapp/model/relation_model.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadImageToFirebase extends ProfileEvent {
  final File url;
  UploadImageToFirebase({this.url});
  @override
  List<Object> get props => [url];
}

class SaveProfileEvent extends ProfileEvent {
  final RelationModel model;
  SaveProfileEvent(this.model);
  @override
  List<Object> get props => [model];
}

class GetUserDetails extends ProfileEvent {}
