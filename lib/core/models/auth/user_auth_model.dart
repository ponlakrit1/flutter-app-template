import 'package:json_annotation/json_annotation.dart';

part 'user_auth_model.g.dart';

@JsonSerializable()
class UserAuthModel {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  UserAuthModel({required this.accessToken, required this.refreshToken});

  factory UserAuthModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthModelToJson(this);
}
