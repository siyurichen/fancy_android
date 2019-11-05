import 'package:fancy_android/model/latest_article_model.dart' as articleModel;
import 'package:fancy_android/page/article/article_item_page.dart';
import 'package:fancy_android/page/widget/custom_list_view/custom_list_view.dart';
import 'package:flutter/material.dart';

typedef Future<articleModel.Data> RequestData(int page);
typedef Widget Header<T>();

class CommonArticleListPage<T> extends StatefulWidget {
  final Widget header;
  final String title;
  final String url;
  final int itemType;
  final int page;
  final int pageSize;
  final RequestData request;

  CommonArticleListPage({
    Key key,
    this.header,
    this.title = '',
    this.url,
    this.itemType,
    this.page = 0,
    this.pageSize = 20,
    this.request,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CommonArticleListPageState();
}

class _CommonArticleListPageState<T> extends State<CommonArticleListPage>
    with AutomaticKeepAliveClientMixin {
  CustomListView<articleModel.Datas> _customListView;

  List<articleModel.Datas> _list = [];

  @override
  void initState() {
    super.initState();
    _customListView = new CustomListView<articleModel.Datas>(
      header: null != widget.header ? widget.header : null,
      pageRequest: loadData,
      itemBuilder: getItem,
      enableLoadMore: true,
      page: widget.page,
      pageSize: widget.pageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      appBar: widget.title.isNotEmpty
          ? new AppBar(
              title: new Text(widget.title),
            )
          : null,
      body: _customListView,
    );
  }

  Future<List<articleModel.Datas>> loadData(int page, int pageSize) async {
    await widget.request(page).then((result) {
      return _list = result.datas;
    });
    return _list;
  }

  Widget getItem(List<articleModel.Datas> list, int index) {
    return ArticleItemPage(
      articleModel: list[index],
      itemType: widget.itemType,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
