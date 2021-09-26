import 'package:dating_idea/data/model/json_converter/user_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  @UserConverter()
  final User user;
  final String message;

  LoginResponse({this.user, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
