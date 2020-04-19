import 'package:bloc/bloc.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_event.dart';
import 'package:flutterapp/blocs/reln_bloc/relation_state.dart';
import 'package:flutterapp/model/relation_model.dart';
import 'package:flutterapp/repository/user_repo.dart';

class RelationBloc extends Bloc<RelationEvents, RelationState> {
  UserRepository userRepository;
  RelationBloc(this.userRepository);

  @override
  RelationState get initialState => RelationEmptyState();

  @override
  Stream<RelationState> mapEventToState(RelationEvents event) async* {
    if (event is RelationListPressed) {
      try {
        yield RelationLoadingState();

        /// getting relation list
        Map<String, Object> model =
            await userRepository.getRelationList(userId: event.userId);

        /// getting relation list
        RelationModel user = await userRepository.getUserDetails();

        ///puttin in map
        model["user"] = user;

        yield RelationLoadedState(data: model);
      } catch (e) {
        print(e);
        yield RelationLoadFailureState(error: e.toString());
      }
    }

    if (event is RelationAddPressed) {
      try {
        yield RelationLoadingState();

        String result = await userRepository.addRelation(
          name: event.name,
          mobile: event.mobile,
          email: event.email,
          address: event.address,
          relation: event.relation,
          avtar: event.relation,
        );
        print("00-" + result);

        /// RelationAddedState
        yield RelationAddedState();
      } catch (e) {
        print(e);
        yield RelationLoadFailureState(error: e.toString());
      }
    }

    if (event is RelationStoreSinglePressed) {
      try {
        yield RelationLoadingState();

        yield RelationStoredState(model: event.model);
      } catch (e) {
        print(e);
        yield RelationLoadFailureState(error: e.toString());
      }
    }

    if (event is RelationGetSinglePressed) {
      try {
        yield RelationLoadingState();
      } catch (e) {
        print(e);
        yield RelationLoadFailureState(error: e.toString());
      }
    }
  }
}
