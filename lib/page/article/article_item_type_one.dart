import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeOne extends StatelessWidget {
  final article.Datas articleModel;

  ArticleItemTypeOne({Key key, this.articleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  Widget _buildItem(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  articleModel?.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 6),
                child: Text(DateUtil.getTimeDuration(articleModel.publishTime)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 6),
                child: Text(articleModel.superChapterName +
                    '/' +
                    articleModel.chapterName),
              ),
            ],
          ),
        ),
        onTap: () {
          NavigatorUtil.navigatorWebWithCollect(context, articleModel?.link,
              articleModel?.title, articleModel?.collect, articleModel?.id);
        },
      ),
    );
  }
}
