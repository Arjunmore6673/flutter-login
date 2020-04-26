import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class IntitalState extends ProfileState {}

class Loading extends ProfileState {}

class UploadedImage extends ProfileState {
  final String downloadUrl;
  UploadedImage({this.downloadUrl});
  @override
  List<Object> get props => [downloadUrl];
}

class SavedProfile extends ProfileState {}

class SaveError extends ProfileState {
  final String error;
  SaveError({this.error});
  @override
  List<Object> get props => [error];
}

class UploadError extends ProfileState {
  final String error;
  UploadError({this.error});
  @override
  List<Object> get props => [error];
}
