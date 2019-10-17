import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/model/home_banner.dart' as banner;
import 'package:fancy_android/model/latest_article.dart';
import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/size_util.dart';
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
    DataUtil.getBanner().then((result) {
      setState(() {
        banners = result.data;
      });
    });
  }

  //轮播图
  Widget _buildBanner() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          banners[index].imagePath,
          fit: BoxFit.fill,
        );
      },
      itemCount: banners.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.lightBlue[50],
          activeColor: Colors.blue,
          size: SizeUtil.px(16),
        ),
      ),
      controller: SwiperController(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      autoplayDelay: 5000,
    );
  }

  getLatestArticle(int page) {
    DataUtil.getLatestArticle(page).then((result) {
      setState(() {
        latestArticles = result.datas;
      });
    });
  }

  getLatestArticleProject(int page) {
    DataUtil.getLatestArticleProject(page).then((result) {
      setState(() {
        latestArticleProjects = result.datas;
      });
    });
  }

  //Tab
  Widget _buildTabItem(String itemText) {
    return Container(
      alignment: Alignment.center,
      height: SizeUtil.px(90),
      child: Text(
        itemText,
        style: TextStyle(
          fontSize: SizeUtil.px(30),
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //最新博文
  Widget _buildLatestArticle(List<Datas> latestArticles) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(SizeUtil.px(20)),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(latestArticles[index]);
      },
      itemCount: latestArticles.length,
    );
  }

  Widget _buildItem(Datas article) {
    return Card(
      elevation: SizeUtil.px(5),
      child: Container(
        padding: EdgeInsets.all(SizeUtil.px(20)),
        child: Column(
          children: <Widget>[
            _buildTitle(article),
            _buildCategory(article),
            _buildAuthorAndRefreshLabel(article),
          ],
        ),
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
              fontSize: SizeUtil.px(32),
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
      margin: EdgeInsets.only(top: SizeUtil.px(20)),
      child: Text(
        '分类:' + article.superChapterName + ' / ' + article.chapterName,
        style: TextStyle(fontSize: SizeUtil.px(24), color: Colors.black54),
      ),
    );
  }

  Widget _buildAuthorAndRefreshLabel(Datas article) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: SizeUtil.px(20)),
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
      style: TextStyle(fontSize: SizeUtil.px(24), color: Colors.black54),
    );
  }

  Widget _buildRefreshLabel(Datas article) {
    if (article.fresh) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: SizeUtil.px(2))),
        width: SizeUtil.px(40),
        margin: EdgeInsets.only(right: SizeUtil.px(12)),
        child: Text(
          '新',
          style: TextStyle(fontSize: SizeUtil.px(24), color: Colors.red),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          '',
          style: TextStyle(fontSize: SizeUtil.px(24), color: Colors.red),
        ),
      );
    }
  }

  Widget _buildUpdateTime(Datas article) {
    return Text(
      '时间:' + DateUtil.getTimeDuration(article.publishTime),
      style: TextStyle(fontSize: SizeUtil.px(24), color: Colors.black54),
    );
  }

  //最新项目
  Widget _buildArticleProject(List<Datas> latestArticleProjects) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(SizeUtil.px(20)),
      itemBuilder: (BuildContext context, int index) {
        return _buildArticleProjectItem(latestArticleProjects[index]);
      },
      itemCount: latestArticleProjects.length,
    );
  }

  Widget _buildArticleProjectItem(Datas article) {
    return Card(
      elevation: SizeUtil.px(5),
      child: Container(
        padding: EdgeInsets.all(SizeUtil.px(20)),
        child: Row(
          children: <Widget>[
            _buildItemLeft(article),
            _buildItemRight(article),
          ],
        ),
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
                fontSize: SizeUtil.px(32),
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: SizeUtil.px(10)),
            child: Text(
              article.desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeUtil.px(28),
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: SizeUtil.px(10)),
            child: Row(
              children: <Widget>[
                Text(
                  DateUtil.getTimeDuration(article.publishTime),
                  style: TextStyle(
                    fontSize: SizeUtil.px(24),
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: SizeUtil.px(10)),
                  child: Text(
                    article.author,
                    style: TextStyle(
                      fontSize: SizeUtil.px(24),
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
        margin: EdgeInsets.only(left: SizeUtil.px(10)),
        width: SizeUtil.px(60),
        height: SizeUtil.px(200),
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
