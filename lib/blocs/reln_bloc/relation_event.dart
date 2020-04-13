import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/relation_model.dart';

class RelationEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class RelationListPressed extends RelationEvents {
  final int userId;

  RelationListPressed({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class RelationAddPressed extends RelationEvents {
  final String name;
  final String mobile;
  final String address;
  final String relation;

  RelationAddPressed(
      {@required this.name, this.mobile, this.address, this.relation});

  @override
  List<Object> get props => [name, mobile, address, relation];
}

class RelationGetSinglePressed extends RelationEvents {
  final int id;
  RelationGetSinglePressed({@required this.id});

  @override
  List<Object> get props => [id];
}

class RelationStoreSinglePressed extends RelationEvents {
  final RelationModel model;
  RelationStoreSinglePressed({@required this.model});

  @override
  List<Object> get props => [model];
}
