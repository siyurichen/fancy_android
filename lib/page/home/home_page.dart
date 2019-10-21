import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/latest_article_model.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:fancy_android/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;

  List<Datas> latestArticles = [];
  List<Datas> latestArticleProjects = [];
  List<banner.Data> banners = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    scrollController = ScrollController(initialScrollOffset: 0.0);
    getLatestArticle(0);
    getLatestArticleProject(0);
    getBanner();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //是否随着滑动隐藏标题
              pinned: false,
              //展开高度
              floating: true,
              primary: true,
              //是否预留高度
              forceElevated: innerBoxIsScrolled,
              //与floating结合使用
              expandedHeight: 200.0,
              //是否固定在顶部
              flexibleSpace: FlexibleSpaceBar(
                background: _buildBanner(),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    _buildTabItem('最新博文'),
                    _buildTabItem('最新项目'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            _buildLatestArticle(latestArticles),
            _buildArticleProject(latestArticleProjects),
          ],
        ),
      ),
    );
  }

  getBanner() {
    HttpMethods.getBanner().then((result) {
      setState(() {
        if (result.data.length <= 0) return;
        banners = result.data;
      });
    });
  }

  //轮播图
  Widget _buildBanner() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Image.network(
            banners[index]?.imagePath,
            fit: BoxFit.fill,
          ),
          onTap: () {
            NavigatorUtil.navigatorWeb(
                context, banners[index]?.url, banners[index]?.title);
          },
        );
      },
      itemCount: banners?.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.lightBlue[50],
          activeColor: Colors.blue,
          size: 8,
        ),
      ),
      controller: SwiperController(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      autoplayDelay: 5000,
    );
  }

  getLatestArticle(int page) {
    HttpMethods.getLatestArticle(page).then((result) {
      setState(() {
        latestArticles = result.datas;
      });
    });
  }

  getLatestArticleProject(int page) {
    HttpMethods.getLatestArticleProject(page).then((result) {
      setState(() {
        latestArticleProjects = result.datas;
      });
    });
  }

  //Tab
  Widget _buildTabItem(String itemText) {
    return Tab(
      text: itemText,
    );
  }

  //最新博文
  Widget _buildLatestArticle(List<Datas> latestArticles) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(latestArticles[index]);
      },
      itemCount: latestArticles.length,
    );
  }

  Widget _buildItem(Datas article) {
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
          NavigatorUtil.navigatorWeb(context, article.link, article.title);
        },
      ),
    );
  }

  Widget _buildTitle(Datas article) {
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

  Widget _buildCategory(Datas article) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '分类:' + article.superChapterName + ' / ' + article.chapterName,
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }

  Widget _buildAuthorAndRefreshLabel(Datas article) {
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

  Widget _buildAuthor(Datas article) {
    return Text(
      article.author.isEmpty
          ? '分享人:' + article.shareUser
          : '作者:' + article.author,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _buildRefreshLabel(Datas article) {
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

  Widget _buildUpdateTime(Datas article) {
    return Text(
      '时间:' + DateUtil.getTimeDuration(article.publishTime),
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  //最新项目
  Widget _buildArticleProject(List<Datas> latestArticleProjects) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        return _buildArticleProjectItem(latestArticleProjects[index]);
      },
      itemCount: latestArticleProjects.length,
    );
  }

  Widget _buildArticleProjectItem(Datas article) {
    return Card(
      elevation: 5,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              _buildItemLeft(article),
              _buildItemRight(article),
            ],
          ),
        ),
        onTap: () {
          NavigatorUtil.navigatorWeb(context, article.link, article.title);
        },
      ),
    );
  }

  Widget _buildItemLeft(Datas article) {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              article.title,
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
            margin: EdgeInsets.only(top: 10),
            child: Text(
              article.desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  DateUtil.getTimeDuration(article.publishTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    article.author,
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

  Widget _buildItemRight(Datas article) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 60,
        height: 100,
        child: FadeInImage.assetNetwork(
          placeholder: 'images/icon_place_holder.png',
          image: article.envelopePic,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _SliverAppBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
