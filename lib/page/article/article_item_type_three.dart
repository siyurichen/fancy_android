import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeThree extends StatefulWidget {
  final article.Datas articleModel;

  ArticleItemTypeThree({Key key, this.articleModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemTypeThreeState();
  }
}

class ArticleItemTypeThreeState extends State<ArticleItemTypeThree> {
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
              _buildTitle(),
              _buildCategoryAndAuthor(),
              _buildUpdateTimeAndFavorite(),
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

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          _buildRefreshLabel(),
          Expanded(
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
        ],
      ),
    );
  }

  Widget _buildCategoryAndAuthor() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildCategory(),
          _buildAuthorAndRefreshLabel(),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Text(
      articleModel.superChapterName + ' / ' + articleModel.chapterName,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _buildAuthorAndRefreshLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildAuthor(),
      ],
    );
  }

  Widget _buildAuthor() {
    return Text(
      articleModel.author.isEmpty
          ? '分享人:' + articleModel.shareUser
          : '作者:' + articleModel.author,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _buildRefreshLabel() {
    if (articleModel.fresh) {
      return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
        width: 14,
        margin: EdgeInsets.only(right: 3),
        child: Text(
          '新',
          style: TextStyle(fontSize: 10, color: Colors.red),
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

  Widget _buildUpdateTimeAndFavorite() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              articleModel.niceDate,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            GestureDetector(
              child: Icon(
                Icons.favorite,
                color: articleModel.collect ? Colors.red : Colors.grey,
              ),
              onTap: () {
                setState(() {
                  articleModel.collect = !articleModel.collect;
                });
              },
            ),
          ],
        ));
  }
}
