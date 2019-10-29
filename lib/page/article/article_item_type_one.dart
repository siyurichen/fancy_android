import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemTypeOne extends StatefulWidget {
  final article.Datas articleModel;

  ArticleItemTypeOne({Key key, this.articleModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemTypeOneState();
  }
}

class ArticleItemTypeOneState extends State<ArticleItemTypeOne> {
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
                child: Text(articleModel.superChapterName +
                    '/' +
                    articleModel.chapterName),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(articleModel.niceDate),
                    _buildIcon(),
                  ],
                ),
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

  Widget _buildIcon() {
    return GestureDetector(
      child: Icon(
        Icons.favorite,
        color: articleModel.collect ? Colors.red : Colors.grey,
      ),
      onTap: () {
        setState(() {
          articleModel.collect = !articleModel.collect;
        });
      },
    );
  }
}
