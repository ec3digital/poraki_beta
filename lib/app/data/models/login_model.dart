import 'dart:convert';

class LoginModel {
  final String mail;
  final String password;
  final String name;
  final bool keepOn;
  LoginModel({
    required this.mail,
    required this.password,
    required this.name,
    required this.keepOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'mail': mail,
      'password': password,
      "returnSecureToken": true,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      mail: map['mail'],
      password: map['password'],
      name: map['name'],
      keepOn: map['keepOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginModel(mail: $mail, password: $password, name: $name, keepOn: $keepOn)';
  }
}
