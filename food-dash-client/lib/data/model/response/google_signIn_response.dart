import 'package:food_dash/data/model/json_converter/user_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_signIn_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleSignInResponse {
  @UserConverter()
  final User user;

  GoogleSignInResponse(this.user);

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleSignInResponseToJson(this);
}
