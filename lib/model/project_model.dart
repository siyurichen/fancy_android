import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel extends Object {
  Data data;

  int errorCode;

  String errorMsg;

  ProjectModel(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory ProjectModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
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
  String apkLink;

  int audit;

  String author;

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

  String niceShareDate;

  String origin;

  String prefix;

  String projectLink;

  int publishTime;

  int selfVisible;

  int shareDate;

  String shareUser;

  int superChapterId;

  String superChapterName;

  List<Tags> tags;

  String title;

  int type;

  int userId;

  int visible;

  int zan;

  Datas(
    this.apkLink,
    this.audit,
    this.author,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.fresh,
    this.id,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  );

  factory Datas.fromJson(Map<String, dynamic> srcJson) =>
      _$DatasFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatasToJson(this);
}

@JsonSerializable()
class Tags extends Object {
  String name;

  String url;

  Tags(
    this.name,
    this.url,
  );

  factory Tags.fromJson(Map<String, dynamic> srcJson) =>
      _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
