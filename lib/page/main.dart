import 'package:fancy_android/page/home.dart';
import 'package:fancy_android/page/knowledge_system.dart';
import 'package:fancy_android/page/project.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

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
      ..add(Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _selectIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('博文')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('项目')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('体系')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的')),
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
                backgroundImage: AssetImage('images/pic0.jpg'),
              ),
              margin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    if (_selectIndex == 0) {
      return AppBar(
        title: Text('首页'),
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
