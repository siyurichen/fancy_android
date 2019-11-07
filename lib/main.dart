import 'package:fancy_android/model/theme_color_model.dart';
import 'package:fancy_android/model/user_model.dart';
import 'package:fancy_android/page/Home/home_page.dart';
import 'package:fancy_android/page/KnowledgeSystem/knowledge_system.dart';
import 'package:fancy_android/page/Project/project_page.dart';
import 'package:fancy_android/page/wechat/wechat_article.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:fancy_android/util/sharedPreferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_android/model/latest_article_model.dart' as articleModel;

void main() async {
  String colorKey = await SharedPreferencesUtil.getString(
      SharedPreferencesUtil.SHARE_THEME_COLOR,
      defValue: 'blue');
  runApp(MyApp(
    themeColorKey: colorKey,
  ));
}

class MyApp extends StatelessWidget {
  final String themeColorKey;

  MyApp({Key key, this.themeColorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _themeColor;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => UserModel(null, -1, '')),
        ChangeNotifierProvider(
          builder: (_) => articleModel.Datas.origin(),
        ),
        ChangeNotifierProvider.value(value: ThemeColorModel()),
      ],
      child: Consumer<ThemeColorModel>(
        builder: (context, themeColorModel, _) {
          String colorKey = themeColorModel.themeColor ?? themeColorKey;
          if (null != ConstantUtil.themeColorMap[colorKey]) {
            _themeColor = ConstantUtil.themeColorMap[colorKey];
          }

          return MaterialApp(
            theme: ThemeData.light().copyWith(
              primaryColor: _themeColor,
              accentColor: _themeColor,
              indicatorColor: _themeColor,
            ),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectIndex = 0;
  List<Widget> _list = List();
  List<String> tabs = ['玩安卓', '发现', '知识体系', '公众号'];

  @override
  void initState() {
    super.initState();
    _list
      ..add(HomePage())
      ..add(ProjectPage())
      ..add(KnowledgeSystem())
      ..add(WeChatArticlePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: IndexedStack(
        index: _selectIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('主页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text('发现')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('体系')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('公众号')),
        ],
        currentIndex: _selectIndex,
        onTap: _onTap,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:
                  Consumer<UserModel>(builder: (context, userModel, child) {
                return Text(
                    userModel.data == null ? '' : userModel.data.nickname);
              }),
              accountEmail: Text('test@126.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/icon_head.jpg'),
                ),
                onTap: () {
                  NavigatorUtil.navigatorLogin(context);
                },
              ),
              margin: EdgeInsets.zero,
            ),
            _buildDrawerItem('我的收藏', Icons.favorite),
            _buildDrawerItem('设置', Icons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String itemText, IconData icon) {
    return InkWell(
      child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  itemText,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
      onTap: () {
        if ('我的收藏' == itemText) {
          NavigatorUtil.navigatorFavoriteArticle(context);
        } else if ('设置' == itemText) {
          NavigatorUtil.navigatorSettingPage(context);
        }
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        tabs[_selectIndex],
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              NavigatorUtil.navigatorSearch(context);
            }),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}
