import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/project_category_model.dart' as category;
import 'package:fancy_android/page/article/common_article_list_page.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  static List<category.Data> _categories = [];

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
    HttpMethods.getInstance().getProjectCategory().then((result) {
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
      return CommonArticleListPage(
        request: (page) {
          return HttpMethods.getInstance()
              .getArticle("${Api.PROJECT_URL}$page/json?cid=${category.id}");
        },
        itemType: ConstantUtil.ARTICLE_ITEM_TYPE_TWO,
        page: 1,
        pageSize: 15,
      );
    })?.toList();
  }

  @override
  bool get wantKeepAlive => true;
}
