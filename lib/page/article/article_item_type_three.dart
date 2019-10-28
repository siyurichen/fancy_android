import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeThree extends StatelessWidget {
  final article.Datas articleModel;

  ArticleItemTypeThree({Key key, this.articleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context, articleModel);
  }

  Widget _buildItem(BuildContext context, article.Datas article) {
    return Card(
      elevation: 5,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildTitle(article),
              _buildCategory(article),
              _buildAuthorAndRefreshLabel(article),
            ],
          ),
        ),
        onTap: () {
          NavigatorUtil.navigatorWebWithCollect(context, article?.link, article?.title,
              article?.collect, article?.id);
        },
      ),
    );
  }

  Widget _buildTitle(article.Datas article) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            article.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(article.Datas article) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '分类:' + article.superChapterName + ' / ' + article.chapterName,
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }

  Widget _buildAuthorAndRefreshLabel(article.Datas article) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildRefreshLabel(article),
              _buildAuthor(article),
            ],
          ),
          _buildUpdateTime(article),
        ],
      ),
    );
  }

  Widget _buildAuthor(article.Datas article) {
    return Text(
      article.author.isEmpty
          ? '分享人:' + article.shareUser
          : '作者:' + article.author,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _buildRefreshLabel(article.Datas article) {
    if (article.fresh) {
      return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
        width: 20,
        margin: EdgeInsets.only(right: 12),
        child: Text(
          '新',
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          '',
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      );
    }
  }

  Widget _buildUpdateTime(article.Datas article) {
    return Text(
      '时间:' + DateUtil.getTimeDuration(article.publishTime),
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}
