// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserRO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRO _$UserROFromJson(Map<String, dynamic> json) {
  return UserRO(
    User.fromJson(json['user'] as Map<String, dynamic>),
    json['token'] as String,
  );
}

Map<String, dynamic> _$UserROToJson(UserRO instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'token': instance.token,
    };
