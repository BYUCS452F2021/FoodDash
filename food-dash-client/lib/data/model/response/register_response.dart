import 'package:dating_idea/data/model/json_converter/user_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponse {
  @UserConverter()
  final User user;
  final String message;

  RegisterResponse({this.user, this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
