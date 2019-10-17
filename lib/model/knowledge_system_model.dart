import 'package:json_annotation/json_annotation.dart';

part 'knowledge_system_model.g.dart';

@JsonSerializable()
class KnowledgeSystemModel extends Object {
  List<Data> data;

  int errorCode;

  String errorMsg;

  KnowledgeSystemModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory KnowledgeSystemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$KnowledgeSystemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$KnowledgeSystemModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  List<Children> children;

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

@JsonSerializable()
class Children extends Object {
  List<String> children;

  int courseId;

  int id;

  String name;

  int order;

  int parentChapterId;

  bool userControlSetTop;

  int visible;

  Children(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory Children.fromJson(Map<String, dynamic> srcJson) =>
      _$ChildrenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildrenToJson(this);
}
