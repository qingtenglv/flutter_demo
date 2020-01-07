// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tree _$TreeFromJson(Map<String, dynamic> json) {
  return Tree()
    ..children = (json['children'] as List)
        ?.map(
            (e) => e == null ? null : Tree.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..courseId = json['courseId'] as int
    ..id = json['id'] as int
    ..name =  StringUtils.urlDecoder( json["name"])
    ..order = json['order'] as int
    ..parentChapterId = json['parentChapterId'] as int
    ..userControlSetTop = json['userControlSetTop'] as bool
    ..visible = json['visible'] as int;
}

Map<String, dynamic> _$TreeToJson(Tree instance) => <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
