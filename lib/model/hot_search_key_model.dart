import 'package:json_annotation/json_annotation.dart';

part 'hot_search_key_model.g.dart';

@JsonSerializable()
class HotSearchKeyModel extends Object {
  List<Data> data;

  int errorCode;

  String errorMsg;

  HotSearchKeyModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory HotSearchKeyModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchKeyModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchKeyModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  int id;

  String link;

  String name;

  int order;

  int visible;

  Data(
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
