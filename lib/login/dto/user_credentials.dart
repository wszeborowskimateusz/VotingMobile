import 'package:json_annotation/json_annotation.dart';

part 'user_credentials.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class UserCredentials {
  final String login;
  final String password;

  const UserCredentials({this.login, this.password});

  Map<String, dynamic> toJson() => _$UserCredentialsToJson(this);
}
