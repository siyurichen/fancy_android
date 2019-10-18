import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/util/size_util.dart';
import 'package:flutter/material.dart';

class KnowledgeSystem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new KnowledgeSystemState();
  }
}

class KnowledgeSystemState extends State<KnowledgeSystem> {
  List<system.Data> systems = [];
  ScrollController scrollController = new ScrollController();
  bool isShowBtn = false; //点击回到顶部按钮是否显示

  @override
  void initState() {
    super.initState();
    getKnowledgeSystem();
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
      appBar: AppBar(
        title: Text('知识体系'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      body: _buildListViewBuilder(),
      floatingActionButton: isShowBtn
          ? FloatingActionButton(
              child: Icon(Icons.arrow_upward),
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
      padding: EdgeInsets.all(SizeUtil.px(20)),
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
            margin: EdgeInsets.only(top: SizeUtil.px(20)),
            child: Text(
              data.name,
              style: TextStyle(
                fontSize: SizeUtil.px(32),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: SizeUtil.px(20)),
            child: Wrap(
              children: _buildWrapChildren(data),
              runSpacing: SizeUtil.px(10),
              spacing: SizeUtil.px(10),
            ),
          ),
          _buildItemGapLine(),
        ],
      ),
    );
  }

  Widget _buildItemGapLine() {
    return Container(
      margin: EdgeInsets.only(top: SizeUtil.px(20)),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                height: SizeUtil.px(1),
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
    return Container(
      constraints: BoxConstraints(
        minWidth: SizeUtil.px(80),
      ),
      padding: EdgeInsets.fromLTRB(
          SizeUtil.px(16), SizeUtil.px(8), SizeUtil.px(16), SizeUtil.px(8)),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular((20.0)),
      ),
      child: Text(
        children.name,
        style: TextStyle(
          fontSize: SizeUtil.px(28),
          color: Colors.black,
        ),
      ),
    );
  }

  getKnowledgeSystem() async {
    DataUtil.getKnowledgeSystem().then((result) {
      setState(() {
        systems = result.data;
      });
    });
  }
}
