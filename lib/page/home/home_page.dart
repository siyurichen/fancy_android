import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/latest_article_model.dart';
import 'package:fancy_android/page/article/article_list_page.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;

  List<Datas> latestArticles = [];
  List<Datas> latestArticleProjects = [];
  List<banner.Data> banners = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    getBanner();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TabBar(
        controller: tabController,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          _buildTabItem('最新博文'),
          _buildTabItem('最新项目'),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ArticleListPage(
            request: (page) {
              return HttpMethods.getArticle(
                  "${Api.LATEST_ARTICLE_URL}$page/json");
            },
            itemType: 3,
            showAppBar: false,
            header: _buildBanner(),
          ),
          ArticleListPage(
            request: (page) {
              return HttpMethods.getArticle(
                  "${Api.LATEST_ARTICLE_PROJECT_URL}$page/json");
            },
            itemType: 2,
            showAppBar: false,
          ),
        ],
      ),
    );
  }

  getBanner() {
    HttpMethods.getBanner().then((result) {
      setState(() {
        if (result.data.length <= 0) return;
        banners.clear();
        banners.addAll(result.data);
      });
    });
  }

  //轮播图
  Widget _buildBanner() {
    //一定要设置高度，不然就报如下错误
    //RenderRepaintBoundary#2f440 relayoutBoundary=up2 NEEDS-PAINT
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
    return Container(
      height: screenWidth * 500 / 900,
      width: screenWidth,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage.assetNetwork(
                placeholder: '',
                image: banners[index]?.imagePath,
                fit: BoxFit.cover,
              ),
            ),
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
        //没有请求到数据时设置为不自动播放，否则会连续快速滚动
        autoplay: banners.isNotEmpty,
        autoplayDelay: 5000,
        loop: true,
        onTap: (int index) {
          NavigatorUtil.navigatorWeb(
              context, banners[index]?.url, banners[index]?.title);
        },
      ),
    );
  }

  //Tab
  Widget _buildTabItem(String itemText) {
    return Tab(
      text: itemText,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
