// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_signIn_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSignInResponse _$GoogleSignInResponseFromJson(Map<String, dynamic> json) {
  return GoogleSignInResponse(
    const UserConverter().fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoogleSignInResponseToJson(
        GoogleSignInResponse instance) =>
    <String, dynamic>{
      'user': const UserConverter().toJson(instance.user),
    };
