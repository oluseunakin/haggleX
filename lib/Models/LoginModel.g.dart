// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInput _$LoginInputFromJson(Map<String, dynamic> json) {
  return LoginInput(
    json['input'] as String?,
    json['password'] as String?,
  );
}

Map<String, dynamic> _$LoginInputToJson(LoginInput instance) =>
    <String, dynamic>{
      'input': instance.input,
      'password': instance.password,
    };
