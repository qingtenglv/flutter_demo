// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site()
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cid = json['cid'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name
    };
