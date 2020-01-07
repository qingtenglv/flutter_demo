import 'package:demo/utils/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'tags.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Article();

  String apkLink;
  String author;
  String shareUser;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  String prefix;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tags> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}
