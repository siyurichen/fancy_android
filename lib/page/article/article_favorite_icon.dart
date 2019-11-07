import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;

class ArticleFavoriteIcon extends StatefulWidget {
  final article.Datas articleModel;

  ArticleFavoriteIcon({
    Key key,
    this.articleModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ArticleFavoriteIconState();
}

class ArticleFavoriteIconState extends State<ArticleFavoriteIcon> {
  article.Datas articleModel;
  bool collect;

  @override
  void initState() {
    super.initState();
    articleModel = widget.articleModel;
  }

  @override
  Widget build(BuildContext context) {
    return _buildIcon();
  }

  Widget _buildIcon() {
    return GestureDetector(
      child: Icon(
        Icons.favorite,
        color:
            articleModel.collect ? Theme.of(context).primaryColor : Colors.grey,
      ),
      onTap: () {
        cancelOrFavoriteArticle(articleModel.id);
      },
    );
  }

  ///取消或者收藏文章
  cancelOrFavoriteArticle(int articleId) async {
    String url = articleModel.collect
        ? "${Api.CANCEL_FAVORITE_ARTICLE_URL}$articleId/json"
        : "${Api.FAVORITE_ARTICLE_URL}$articleId/json";
    HttpMethods.getInstance().doOptionRequest(url: url).then((result) {
      setState(() {
        if (result == 0) {
          articleModel.collect = !articleModel.collect;
        } else if (result == -1001) {
          NavigatorUtil.navigatorLogin(context);
        }
      });
    });
  }
}
