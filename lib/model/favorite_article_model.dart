import 'package:json_annotation/json_annotation.dart';

part 'favorite_article_model.g.dart';

@JsonSerializable()
class FavoriteArticleModel extends Object {
  Data data;

  int errorCode;

  String errorMsg;

  FavoriteArticleModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory FavoriteArticleModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FavoriteArticleModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FavoriteArticleModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  int curPage;

  List<Datas> datas;

  int offset;

  bool over;

  int pageCount;

  int size;

  int total;

  Data(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Datas extends Object {
  String author;

  int chapterId;

  String chapterName;

  int courseId;

  String desc;

  String envelopePic;

  int id;

  String link;

  String niceDate;

  String origin;

  int originId;

  int publishTime;

  String title;

  int userId;

  int visible;

  int zan;

  Datas(
    this.author,
    this.chapterId,
    this.chapterName,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.originId,
    this.publishTime,
    this.title,
    this.userId,
    this.visible,
    this.zan,
  );

  factory Datas.fromJson(Map<String, dynamic> srcJson) =>
      _$DatasFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatasToJson(this);
}
