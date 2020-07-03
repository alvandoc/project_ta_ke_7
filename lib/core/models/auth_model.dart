
class RegisterModel {
  String username;
  String password;
  String name;
  String email;
  String phone;

  RegisterModel({
    this.username, this.password,
    this.name, this.email, this.phone
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "name": name,
      "email": email,
      "phone": phone
    };
  }

}

class UserModel {
  String username;
  String name;
  String email;
  String phone;

  UserModel({
    this.username, this.name,
    this.email, this.phone
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      username: map["username"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "name": name,
      "email": email,
      "phone": phone
    };
  }
}