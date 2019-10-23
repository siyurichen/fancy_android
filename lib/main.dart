import 'package:fancy_android/page/Home/home_page.dart';
import 'package:fancy_android/page/KnowledgeSystem/knowledge_system.dart';
import 'package:fancy_android/page/Project/project_page.dart';
import 'package:fancy_android/page/wechat/wechat_article.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
        fixedColor: Colors.blue,
        onTap: _onTap,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('test'),
              accountEmail: Text('test@126.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/icon_head.jpg'),
              ),
              margin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    if (_selectIndex == 0) {
      return AppBar(
        centerTitle: true,
        title: Text(
          '首页',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                NavigatorUtil.navigatorSearch(context);
              }),
        ],
      );
    } else {
      return null;
    }
  }

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}
