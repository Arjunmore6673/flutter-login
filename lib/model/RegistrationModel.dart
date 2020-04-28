class RegistrationModel {
  final String name;
  final String mobile;
  final String email;
  final String password;
  final String gender;
  final String dob;
  final String address;

  RegistrationModel(this.name, this.mobile, this.email, this.password,
      this.gender, this.dob, this.address);

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["mobile"] = mobile;
    map["email"] = email;
    map["gender"] = gender;
    map["password"] = password;
    map["dob"] = dob;
    map["address"] = address;
    return map;
  }




  @override
  String toString() {
    return 'RegistrationModel{name: $name, mobile: $mobile, password: $password, gender: $gender, dob: $dob, address: $address}';
  }


}
