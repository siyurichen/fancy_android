import 'package:json_annotation/json_annotation.dart';

part 'we_chat_article_category.g.dart';

@JsonSerializable()
class WeChatArticleCategory extends Object {
  List<Data> data;

  int errorCode;

  String errorMsg;

  WeChatArticleCategory(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory WeChatArticleCategory.fromJson(Map<String, dynamic> srcJson) =>
      _$WeChatArticleCategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WeChatArticleCategoryToJson(this);
}

@JsonSerializable()
class Data extends Object {
  List<dynamic> children;

  int courseId;

  int id;

  String name;

  int order;

  int parentChapterId;

  bool userControlSetTop;

  int visible;

  Data(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
