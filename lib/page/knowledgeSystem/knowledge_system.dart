import 'dart:math';

import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/util/constant_util.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';

class KnowledgeSystem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _KnowledgeSystemState();
  }
}

class _KnowledgeSystemState extends State<KnowledgeSystem>
    with AutomaticKeepAliveClientMixin {
  List<system.Data> systems = [];
  ScrollController scrollController = new ScrollController();
  bool isShowBtn = false; //点击回到顶部按钮是否显示

  @override
  void initState() {
    super.initState();
    _getKnowledgeSystem();
    scrollController.addListener(() {
      if (scrollController.offset < 1000 && isShowBtn) {
        setState(() {
          isShowBtn = false;
        });
      } else if (scrollController.offset >= 1000 && isShowBtn == false) {
        setState(() {
          isShowBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: _buildListViewBuilder(),
      floatingActionButton: isShowBtn
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.arrow_upward,
              ),
              onPressed: () {
                scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            )
          : null,
    );
  }

  Widget _buildListViewBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(systems[index]);
      },
      itemCount: systems.length,
    );
  }

  Widget _buildItem(system.Data data) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              data.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              children: _buildWrapChildren(data),
              runSpacing: 5,
              spacing: 5,
            ),
          ),
          _buildItemGapLine(),
        ],
      ),
    );
  }

  Widget _buildItemGapLine() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: Color(0xFFEAEAEA),
              )),
        ],
      ),
    );
  }

  List<Widget> _buildWrapChildren(system.Data data) {
    return data.children.map((children) {
      return _buildLabel(children);
    }).toList();
  }

  Widget _buildLabel(system.Children children) {
    return GestureDetector(
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.all(6),
          child: Text(
            children.name,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              shadows: [Shadow(color: Colors.grey, offset: Offset(0.2, 0.2))],
            ),
          ),
          color: _getRandomColor(),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: () {
        NavigatorUtil.navigatorCommonArticle(
          context,
          children.name,
          ConstantUtil.ARTICLE_ITEM_TYPE_ONE,
          (page) {
            return HttpMethods.getInstance().getArticle(
                "${Api.KNOWLEDGE_SYSTEM_DETAIL_URL}$page/json?cid=${children.id}");
          },
        );
      },
    );
  }

  _getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }

  _getKnowledgeSystem() async {
    HttpMethods.getInstance().getKnowledgeSystem().then((result) {
      setState(() {
        systems = result.data;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
