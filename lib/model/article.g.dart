// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article()
    ..apkLink = json['apkLink'] as String
    ..author = json['author'] as String
    ..shareUser = json['shareUser'] as String
    ..chapterId = json['chapterId'] as int
    ..chapterName =  StringUtils.urlDecoder( json['chapterName'])
    ..collect =  json['collect'] as bool
    ..courseId = json['courseId'] as int
    ..desc =  StringUtils.urlDecoder(   json['desc'])
    ..envelopePic = json['envelopePic'] as String
    ..fresh = json['fresh'] as bool
    ..id = json['id'] as int
    ..link = json['link'] as String
    ..niceDate = json['niceDate'] as String
    ..origin = json['origin'] as String
    ..originId = json['originId'] as int
    ..prefix = json['prefix'] as String
    ..projectLink = json['projectLink'] as String
    ..publishTime = json['publishTime'] as int
    ..superChapterId = json['superChapterId'] as int
    ..superChapterName =StringUtils.urlDecoder(  json['superChapterName'] )
    ..tags = (json['tags'] as List)
        ?.map(
            (e) => e == null ? null : Tags.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..title = StringUtils.urlDecoder(  json['title'] )
    ..type = json['type'] as int
    ..userId = json['userId'] as int
    ..visible = json['visible'] as int
    ..zan = json['zan'] as int;
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'shareUser': instance.shareUser,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'prefix': instance.prefix,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };
