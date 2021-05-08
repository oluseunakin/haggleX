import 'package:json_annotation/json_annotation.dart';

part 'LoginModel.g.dart';

@JsonSerializable()
class LoginInput {
  LoginInput(this.input, this.password);
  String? input, password;

  factory LoginInput.fromJson(Map<String, dynamic> json) =>
      _$LoginInputFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInputToJson(this);
}
