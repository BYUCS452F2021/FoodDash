// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    user: const UserConverter().fromJson(json['user'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'user': const UserConverter().toJson(instance.user),
      'message': instance.message,
    };
