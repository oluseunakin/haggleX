import 'package:json_annotation/json_annotation.dart';

part 'EmailInput.g.dart';

@JsonSerializable()
class EmailInput {
  EmailInput(this.email);
  String? email;

  factory EmailInput.fromJson(Map<String, dynamic> json) =>
      _$EmailInputFromJson(json);

  Map<String, dynamic> toJson() => _$EmailInputToJson(this);
}
