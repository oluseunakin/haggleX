import 'package:json_annotation/json_annotation.dart';

part 'VerifyUserModel.g.dart';

@JsonSerializable()
class VerifyUserInput {
  int code;
  VerifyUserInput(this.code);

  factory VerifyUserInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserInputFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyUserInputToJson(this);
}
