class RegistrationModel {

  final String name;
  final String mobile;
  final String email;
  final String password;
  final String gender;
  final String dob;
  final String address_1;
  final String country;
  final String state;
  final String city;
  final String pin;


  RegistrationModel(this.name, this.mobile, this.email, this.password,
      this.gender, this.dob, this.address_1, this.country, this.state,
      this.city, this.pin);

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["mobile"] = mobile;
    map["email"] = email;
    map["gender"] = gender;
    map["password"] = password;
    map["dob"] = dob;
    map["address_1"] = address_1;
    map["country"] = country;
    map["state"] = state;
    map["city"] = city;
    map["pin"] = pin;
    return map;
  }
}
