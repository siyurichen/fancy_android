import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeTwo extends StatelessWidget {
  final article.Datas articleModel;

  ArticleItemTypeTwo({Key key, this.articleModel}) : super(key: key);

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
            child: Row(
              children: <Widget>[
                _buildItemLeft(),
                _buildItemRight(),
              ],
            ),
          ),
          onTap: () {
            NavigatorUtil.navigatorWebWithCollect(context, articleModel?.link,
                articleModel?.title, articleModel?.collect, articleModel?.id);
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
