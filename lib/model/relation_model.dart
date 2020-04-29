class RelationModel {
  
  final int id;
  final String mobile;
  final String name;
  final String email;
  final String gender;
  final String relation;
  final String image;
  final String address;
  final String dob;
  final String firebaseId;

  RelationModel(
    this.id,
    this.mobile,
    this.name,
    this.email,
    this.gender,
    this.relation,
    this.image,
    this.address,
    this.dob,
    this.firebaseId,
  );

  String get getName => this.name;
  int get getId => this.id;
  String get getMobile => this.mobile;
  String get getRelation => this.relation;
  String get getEmail => this.email;
  String get getImage => this.image;
  String get getGender => this.gender;
  String get getAddress => this.address;
  String get getDob => this.dob;
  String get getFirebaseId => this.firebaseId;

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["gender"],
      json["relation"],
      json["image"],
      json["address"],
      json["dob"],
      json["firebaseId"],
    );
  }

  factory RelationModel.fromJson2(dynamic json) {
    return RelationModel(
      json["id"],
      json["mobile"],
      json["name"],
      json["email"],
      json["gender"],
      json["relation"],
      json["image"],
      json["address"],
      json["dob"],
      json["firebaseId"],
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.mobile}, ${this.name}, ${this.email}, ${this.relation} }';
  }
}
