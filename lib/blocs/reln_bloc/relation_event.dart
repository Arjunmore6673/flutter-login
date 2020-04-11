import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RelationEvents extends Equatable {
  @override
  List<Object> get props =>  null; 
}

class RelationListPressed extends RelationEvents {
  final int userId;

  RelationListPressed({@required this.userId});

  @override
  List<Object> get props => [userId];
}
