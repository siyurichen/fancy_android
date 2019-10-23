import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemPage extends StatelessWidget {
  final int itemType; //1:体系、搜索结果页的item布局 2：项目分类的页的item布局
  final article.Datas articleModel;

  ArticleItemPage(
      {Key key, @required this.articleModel, @required this.itemType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListViewItem(context);
  }

  Widget _buildListViewItem(BuildContext context) {
    if (itemType == 1) {
      return _buildItem(context);
    }
    return _buildItem1(context);
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
          NavigatorUtil.navigatorWeb(
              context, articleModel?.link, articleModel?.title);
        },
      ),
    );
  }

  Widget _buildItem1(BuildContext context) {
    return Card(
        elevation: 5,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                _buildItemLeft(),
                _buildItemRight(),
              ],
            ),
          ),
          onTap: () {
            NavigatorUtil.navigatorWeb(
                context, articleModel.link, articleModel.title);
          },
        ));
  }

  Widget _buildItemLeft() {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              articleModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              articleModel.desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: <Widget>[
                Text(
                  DateUtil.getTimeDuration(articleModel.publishTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    articleModel.author,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRight() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5),
        width: 60,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: FadeInImage.assetNetwork(
            placeholder: '',
            image: articleModel.envelopePic,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
