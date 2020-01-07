import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  bool admin;
  String email;
  List<Object> collectIds;
  List<Object> chapterTops;
  String icon;
  int id;
  String nickname;
  String password;
  String token;
  int type;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);


}
