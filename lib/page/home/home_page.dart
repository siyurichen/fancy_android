import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/latest_article_model.dart';
import 'package:fancy_android/page/article/common_article_list_page.dart';
import 'package:fancy_android/page/widget/banner_widget.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:flutter/material.dart';

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
          CommonArticleListPage(
            request: (page) {
              return HttpMethods.getInstance()
                  .getArticle("${Api.LATEST_ARTICLE_URL}$page/json");
            },
            itemType: ConstantUtil.ARTICLE_ITEM_TYPE_THREE,
            header: BannerWidget(),
          ),
          CommonArticleListPage(
            request: (page) {
              return HttpMethods.getInstance()
                  .getArticle("${Api.LATEST_ARTICLE_PROJECT_URL}$page/json");
            },
            itemType: ConstantUtil.ARTICLE_ITEM_TYPE_TWO,
          ),
        ],
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
