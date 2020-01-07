// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  return Coin()
    ..coinCount = json['coinCount'] as int
    ..date = json['date'] as int
    ..desc = json['desc'] as String
    ..id = json['id'] as int
    ..type = json['type'] as int
    ..userId = json['userId'] as int
    ..userName = json['userName'] as String
    ..rank = json['rank'] as int;
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'coinCount': instance.coinCount,
      'date': instance.date,
      'desc': instance.desc,
      'id': instance.id,
      'type': instance.type,
      'userId': instance.userId,
      'userName': instance.userName,
      'rank': instance.rank
    };
