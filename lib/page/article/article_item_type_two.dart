import 'package:fancy_android/page/article/article_favorite_icon.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeTwo extends StatefulWidget {
  final article.Datas articleModel;

  ArticleItemTypeTwo({Key key, this.articleModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemTypeTwoState();
  }
}

class ArticleItemTypeTwoState extends State<ArticleItemTypeTwo> {
  article.Datas articleModel;

  @override
  void initState() {
    super.initState();
    articleModel = widget.articleModel;
  }

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildArticleRelated(),
                      _buildArticleImage(),
                    ],
                  ),
                  _buildTimeAndAuthor(),
                ],
              )),
          onTap: () {
            NavigatorUtil.navigatorWebWithCollect(context, articleModel?.link,
                articleModel?.title, articleModel?.collect, articleModel?.id);
          },
        ));
  }

  Widget _buildArticleRelated() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            articleModel.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
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
        ],
      ),
    );
  }

  Widget _buildTimeAndAuthor() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: Row(
        children: <Widget>[
          ArticleFavoriteIcon(articleModel: articleModel),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              articleModel.niceDate,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              articleModel.author,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 6),
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
