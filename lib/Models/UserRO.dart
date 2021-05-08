import 'User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserRO.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRO {
  UserRO(this.user, this.token);
  User user;
  String token;

  factory UserRO.fromJson(Map<String, dynamic> json) => _$UserROFromJson(json);

  Map<String, dynamic> toJson() => _$UserROToJson(this);
}
