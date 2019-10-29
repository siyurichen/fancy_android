import 'package:fancy_android/page/article/article_item_type_one.dart';
import 'package:fancy_android/page/article/article_item_type_three.dart';
import 'package:fancy_android/page/article/article_item_type_two.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleItemPage extends StatefulWidget {
  final int itemType; //1:体系、搜索结果页的item布局 2：项目分类的页的item布局
  final article.Datas articleModel;

  ArticleItemPage(
      {Key key, @required this.articleModel, @required this.itemType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemPageState();
  }
}

class ArticleItemPageState extends State<ArticleItemPage> {

  @override
  Widget build(BuildContext context) {
    return _buildListViewItem(context);
  }

  Widget _buildListViewItem(BuildContext context) {
    if (widget.itemType == 2) {
      return ArticleItemTypeTwo(
        articleModel: widget.articleModel,
      );
    } else if (widget.itemType == 3) {
      return ArticleItemTypeThree(
        articleModel: widget.articleModel,
      );
    }
    return ArticleItemTypeOne(
      articleModel: widget.articleModel,
    );
  }
}
