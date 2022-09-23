import 'dart:io';

class LoginUser {
  String email;
  String firstName;
  String lastName;
  String? userID;
  String? profilePictureURL;
  String? appIdentifier;

  LoginUser(
      {this.email = '',
        this.firstName = '',
        this.lastName = '',
        this.userID = '',
        this.profilePictureURL = ''})
      : appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  String fullName() => '$firstName $lastName';

  factory LoginUser.fromJson(Map<String, dynamic> parsedJson) {
    return LoginUser(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier
    };
  }
}