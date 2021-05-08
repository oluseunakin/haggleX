import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String id, email, username, phonenumber;
  //String referralCode, kycStatus, createdAt;
  //bool active, phoneNumberVerified, emailVerified, suspended;
  //int referralCount, tradeCount;
  //double totalReferralEarning, avgTradeRating;
  User(this.id, this.email, this.username, this.phonenumber);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
