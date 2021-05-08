import 'package:json_annotation/json_annotation.dart';

part 'RegisterModel.g.dart';

@JsonSerializable()
class CreateUserInput {
  CreateUserInput(this.email, this.password, this.username, this.phonenumber,
      this.currency, this.country);
  String? email, password, username, phonenumber, currency, country;

  factory CreateUserInput.fromJson(Map<String, dynamic> json) =>
      _$CreateUserInputFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserInputToJson(this);
}
