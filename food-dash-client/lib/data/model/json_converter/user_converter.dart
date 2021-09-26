import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

class UserConverter implements JsonConverter<User, Map<String, dynamic>> {
  const UserConverter();

  ///The fromJson is not workingcc
  @override
  User fromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  Map<String, dynamic> toJson(User user) {
    return {
      "uid": user.uid,
      "name": user.displayName,
      "photoURL": user.photoURL,
    };
  }
}
