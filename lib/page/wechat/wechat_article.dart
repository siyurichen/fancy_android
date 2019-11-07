import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/we_chat_article_category.dart'
    as weChatArticle;
import 'package:fancy_android/page/article/common_article_list_page.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:flutter/material.dart';

class WeChatArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WeChatArticlePageState();
}

class _WeChatArticlePageState extends State<WeChatArticlePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  static List<weChatArticle.Data> _categories = [];

  @override
  void initState() {
    super.initState();
    getProjectCategory();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: _buildTabBar(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _buildContent(),
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    if (_categories.length <= 0) {
      return null;
    }
    if (null == _tabController) {
      _tabController = TabController(vsync: this, length: _categories.length);
    }
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: _buildTabs(),
    );
  }

  getProjectCategory() async {
    HttpMethods.getInstance().getWeChatArticleCategory().then((result) {
      if (result.data.length <= 0) return;
      setState(() {
        result.data.forEach((_categoryItemModel) {
          _categories.add(_categoryItemModel);
        });
      });
    });
  }

  List<Widget> _buildTabs() {
    return _categories?.map((category) {
      return Tab(
        text: category.name,
      );
    })?.toList();
  }

  List<Widget> _buildContent() {
    return _categories?.map<Widget>((category) {
      return new CommonArticleListPage(
        request: (page) {
          return HttpMethods.getInstance().getArticle(
              "${Api.WE_CHAT_ARTICLE_URL}${category.id}/$page/json");
        },
        itemType: ConstantUtil.ARTICLE_ITEM_TYPE_ONE,
        page: 1,
        pageSize: 15,
      );
    })?.toList();
  }

  @override
  bool get wantKeepAlive => true;
}
