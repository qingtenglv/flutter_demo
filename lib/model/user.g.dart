// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..admin = json['admin'] as bool
    ..email = json['email'] as String
    ..collectIds = json['collectIds'] as List
    ..chapterTops = json['chapterTops'] as List
    ..icon = json['icon'] as String
    ..id = json['id'] as int
    ..nickname = json['nickname'] as String
    ..password = json['password'] as String
    ..token = json['token'] as String
    ..type = json['type'] as int
    ..username = json['username'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'admin': instance.admin,
      'email': instance.email,
      'collectIds': instance.collectIds,
      'chapterTops': instance.chapterTops,
      'icon': instance.icon,
      'id': instance.id,
      'nickname': instance.nickname,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username
    };
