import 'package:json_annotation/json_annotation.dart';

part 'common_use_website_model.g.dart';

@JsonSerializable()
class CommonUseWebsiteModel extends Object {
  List<Data> data;

  int errorCode;

  String errorMsg;

  CommonUseWebsiteModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory CommonUseWebsiteModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CommonUseWebsiteModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonUseWebsiteModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  String icon;

  int id;

  String link;

  String name;

  int order;

  int visible;

  Data(
    this.icon,
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
