// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserInput _$CreateUserInputFromJson(Map<String, dynamic> json) {
  return CreateUserInput(
    json['email'] as String?,
    json['password'] as String?,
    json['username'] as String?,
    json['phonenumber'] as String?,
    json['currency'] as String?,
    json['country'] as String?,
  );
}

Map<String, dynamic> _$CreateUserInputToJson(CreateUserInput instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'phonenumber': instance.phonenumber,
      'currency': instance.currency,
      'country': instance.country,
    };
