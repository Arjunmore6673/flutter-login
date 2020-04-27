import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_event.dart';
import 'package:flutterapp/blocs/profile_bloc/profile_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  ProfileBloc({this.userRepository});
  @override
  ProfileState get initialState => IntitalState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UploadImageToFirebase) {
      yield Loading();
      try {
        String downUrl = await userRepository.uploadFile(event.url);
        yield UploadedImage(downloadUrl: downUrl);
      } catch (e) {
        yield UploadError(error: e);
      }
    }
    if (event is SaveProfileEvent) {
      yield Loading();
      await userRepository.updateUserDeatils(event.model);
      yield SavedProfile();
      try {} catch (e) {
        yield SaveError(error: e);
      }
    }

    if (event is GetUserDetails) {
      RelationModel user = await userRepository.getUserDetails();
      yield UserRetrivedDetails(model: user);
    }
  }
}
