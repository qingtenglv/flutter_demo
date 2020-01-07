import 'package:json_annotation/json_annotation.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin{

  int coinCount;
  int date;
  String desc;
  int id;
  int type;
  int userId;
  String userName;
  int rank;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
  Map<String, dynamic> toJson() => _$CoinToJson(this);

  Coin();


}