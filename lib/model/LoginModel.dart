class LoginModel {
  final username;
  final password;

  LoginModel(this.username, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json["username"], json["password"]);
  }

   String get getUserName =>  this.username;
   String get getPass =>  this.password;

    Map toMap() {
      var map = new Map<String, dynamic>();
      map["username"] = username;
      map["password"] = password;
      return map;
  }


}
