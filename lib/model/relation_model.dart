class RelationModel {
  
  final int id;
  final String mobile;
  final String name;
  final String email;
  final String relation;
  final String image;

  RelationModel(
    this.id,
    this.mobile,
    this.name,
    this.email,
    this.relation,
    this.image,
  );

  String get getName => this.name;
  int get getId => this.id;
  String get getMobile => this.mobile;
  String get getRelation => this.relation;
  String get getEmail => this.email;
  String get getImage => this.image;

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["relation"],
      json["image"],
    );
  }

  factory RelationModel.fromJson2(dynamic json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["relation"],
      json["image"],
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.mobile}, ${this.name}, ${this.email}, ${this.relation} }';
  }
}
