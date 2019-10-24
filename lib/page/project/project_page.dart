import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/project_category_model.dart' as category;
import 'package:fancy_android/page/article/article_list_page.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProjectPageState();
}

class ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  static List<category.Data> _categories = [];
  var _maxCachePageNum = 5;
  var _cachedPageNum = 0;

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
        backgroundColor: Colors.blue,
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
    HttpMethods.getProjectCategory().then((result) {
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
      return new ArticleListPage(
        request: (page) {
          return HttpMethods.getArticle(
              "${Api.PROJECT_URL}$page/json?cid=${category.id}");
        },
        itemType: 2,
        keepAlive: _keepAlive(),
        showAppBar: false,
        startPageIndex: 1,
      );
    })?.toList();
  }

  bool _keepAlive() {
    if (_cachedPageNum < _maxCachePageNum) {
      _cachedPageNum++;
      return true;
    } else {
      return false;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
