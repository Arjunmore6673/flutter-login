class RelationModel {
  
  final int id;
  final String mobile;
  final String name;
  final String email;
  final String relation;

  RelationModel(
    this.id,
    this.mobile,
    this.name,
    this.email,
    this.relation,
  );

  String get getName => this.name;
  int get getId => this.id;
  String get getMobile => this.mobile;
  String get getRelation => this.relation;
  String get getEmail => this.email;

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["relation"],
    );
  }

  factory RelationModel.fromJson2(dynamic json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["relation"],
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.mobile}, ${this.name}, ${this.email}, ${this.relation} }';
  }
}
