// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_use_website_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonUseWebsiteModel _$CommonUseWebsiteModelFromJson(
    Map<String, dynamic> json) {
  return CommonUseWebsiteModel(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$CommonUseWebsiteModelToJson(
        CommonUseWebsiteModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['icon'] as String,
    json['id'] as int,
    json['link'] as String,
    json['name'] as String,
    json['order'] as int,
    json['visible'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
    };
