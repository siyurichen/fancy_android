import 'package:fancy_android/page/article/article_item_type_one.dart';
import 'package:fancy_android/page/article/article_item_type_three.dart';
import 'package:fancy_android/page/article/article_item_type_two.dart';
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
    if (itemType == 2) {
      return ArticleItemTypeTwo(
        articleModel: articleModel,
      );
    } else if (itemType == 3) {
      return ArticleItemTypeThree(
        articleModel: articleModel,
      );
    }
    return ArticleItemTypeOne(
      articleModel: articleModel,
    );
  }
}
