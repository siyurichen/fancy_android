import 'package:json_annotation/json_annotation.dart';

part 'project_category_model.g.dart';

@JsonSerializable()
class ProjectCategoryModel extends Object {
  List<Data> data;

  int errorCode;

  String errorMsg;

  ProjectCategoryModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory ProjectCategoryModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectCategoryModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectCategoryModelToJson(this);
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
