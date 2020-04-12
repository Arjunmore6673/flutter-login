import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RelationState extends Equatable {
  const RelationState();
  @override
  List<Object> get props => [];
}

class RelationEmptyState extends RelationState {}

class RelationLoadingState extends RelationState {}

class RelationLoadedState extends RelationState {
  final Map<String, Object> data;
  const RelationLoadedState({@required this.data});
  @override
  List<Object> get props => [data];
}

class RelationAddedState extends RelationState {
  @override
  List<Object> get props => [];
}

class RelationLoadFailureState extends RelationState {
  final String error;
  const RelationLoadFailureState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}
