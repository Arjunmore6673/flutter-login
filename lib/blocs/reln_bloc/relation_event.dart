import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
