import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/we_chat_article_category.dart'
    as weChatArticle;
import 'package:fancy_android/page/article/common_article_list_page.dart';
import 'package:fancy_android/page/widget/default_loading_widget.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:flutter/material.dart';

class WeChatArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WeChatArticlePageState();
}

class _WeChatArticlePageState extends State<WeChatArticlePage>
    with AutomaticKeepAliveClientMixin {
  static List<weChatArticle.Data> _categories = [];

  @override
  void initState() {
    super.initState();
    getProjectCategory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_categories.length <= 0) {
      return DefaultLoadingWidget();
    } else {
      return DefaultTabController(
        length: _categories.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: _buildTabBar(),
          ),
          body: TabBarView(
            children: _buildContent(),
          ),
        ),
      );
    }
  }

  PreferredSizeWidget _buildTabBar() {
    return TabBar(
      isScrollable: true,
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
    return List.generate(
        _categories.length,
        (index) => Tab(
              text: _categories[index].name,
            ));
  }

  List<Widget> _buildContent() {
    return List.generate(
        _categories.length,
        (index) => CommonArticleListPage(
              request: (page) {
                return HttpMethods.getInstance().getArticle(
                    "${Api.WE_CHAT_ARTICLE_URL}${_categories[index].id}/$page/json");
              },
              itemType: ConstantUtil.ARTICLE_ITEM_TYPE_ONE,
              page: 1,
              pageSize: 15,
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
