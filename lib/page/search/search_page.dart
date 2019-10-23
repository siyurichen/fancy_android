import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/common_use_website_model.dart'
    as commonUseWebsite;
import 'package:fancy_android/model/hot_search_key_model.dart' as hotSearchKey;
import 'package:fancy_android/page/search/search_result_page.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<hotSearchKey.Data> hotKeys = [];
  List<commonUseWebsite.Data> commonUseWebsites = [];

  TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getHotSearchKey();
    getCommonUseWebsite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchTitle(_controller),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _search(_controller.text);
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                focusNode.unfocus();
              }),
        ],
      ),
      body: _buildBody(),
    );
  }

  void _search(String keyName) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchResultPage(keyName: keyName);
    }));
  }

  Widget _buildSearchTitle(TextEditingController controller) {
    return TextField(
      focusNode: focusNode,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: (string) {},
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '搜索关键字',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      controller: controller,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildItem('大家都在搜', _buildWrapHotSearchKey()),
          _buildItem('常用网站', _buildWrapCommonUseWebsite()),
        ],
      ),
    );
  }

  Widget _buildItem(String subTitle, List<Widget> itemWidgets) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              subTitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              children: itemWidgets,
              runSpacing: 5,
              spacing: 5,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWrapHotSearchKey() {
    return hotKeys?.map((keyModel) {
      return _buildHotSearchKeyLabel(keyModel.name);
    })?.toList();
  }

  List<Widget> _buildWrapCommonUseWebsite() {
    return commonUseWebsites?.map((commonUseWebsite) {
      return _buildCommonUseWebsiteLabel(commonUseWebsite);
    })?.toList();
  }

  Widget _buildHotSearchKeyLabel(String name) {
    return GestureDetector(
      child: _buildWrapLabelStyle(name),
      onTap: () {
        _search(name);
      },
    );
  }

  Widget _buildCommonUseWebsiteLabel(commonUseWebsite.Data data) {
    return GestureDetector(
      child: _buildWrapLabelStyle(data.name),
      onTap: () {
        NavigatorUtil.navigatorWeb(context, data.link, data.name);
      },
    );
  }

  Widget _buildWrapLabelStyle(String labelName) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 40,
      ),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular((20.0)),
      ),
      child: Text(
        labelName,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  getHotSearchKey() async {
    HttpMethods.getHotSearchKey().then((result) {
      setState(() {
        hotKeys.clear();
        hotKeys.addAll(result.data);
      });
    });
  }

  getCommonUseWebsite() async {
    HttpMethods.getCommonUseWebsite().then((result) {
      setState(() {
        commonUseWebsites.clear();
        commonUseWebsites.addAll(result.data);
      });
    });
  }
}
