import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Object with ChangeNotifier {
  Data data;

  int errorCode;

  String errorMsg;

  UserModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  setUserInfo(response) {
    data = Data.fromJson(response);
    notifyListeners();
  }

  factory UserModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  bool admin;

  List<dynamic> chapterTops;

  List<dynamic> collectIds;

  String email;

  String icon;

  int id;

  String nickname;

  String password;

  String publicName;

  String token;

  int type;

  String username;

  Data(
    this.admin,
    this.chapterTops,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
