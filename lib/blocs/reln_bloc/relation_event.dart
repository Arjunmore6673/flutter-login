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
  final String email;
  final String image;
  final String gender;
  final String address;
  final String relation;
  final String avtar;

  RelationAddPressed(
      {@required this.name,
      this.mobile,
      this.email,
      this.image,
      this.gender,
      this.address,
      this.relation,
      this.avtar});

  @override
  List<Object> get props =>
      [name, mobile, email, gender, address, relation, avtar];
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

class RelationGetOldData extends RelationEvents {}
