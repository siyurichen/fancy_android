import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/favorite_article_model.dart'
    as favoriteArticle;
import 'package:flutter/material.dart';

class FavoriteArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new FavoriteArticlePageState();
}

class FavoriteArticlePageState extends State<FavoriteArticlePage> {
  List<favoriteArticle.Datas> _favoriteArticles = [];

  @override
  void initState() {
    super.initState();
    getFavoriteArticles(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(context, _favoriteArticles[index]);
      },
      itemCount: _favoriteArticles.length,
    );
  }

  Widget _buildRow(
      BuildContext context, favoriteArticle.Datas favoriteArticle) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildItemText(favoriteArticle.title, 18, true),
                  _buildItemText(favoriteArticle.desc, 14, false),
                  _buildItemText(
                      favoriteArticle.chapterName +
                          ' / ' +
                          favoriteArticle.author,
                      14,
                      false),
                ],
              ),
            ),
            _buildFavoriteIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemText(String text, int textSize, bool isBold) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: isBold ? FontWeight.bold : null),
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    );
  }

  getFavoriteArticles(int page) async {
    HttpMethods.favoriteArticleList(page).then((result) {
      setState(() {
        _favoriteArticles.clear();
        _favoriteArticles.addAll(result?.datas);
      });
    });
  }
}
