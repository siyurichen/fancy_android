import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:ui' as ui;

class BannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<banner.Data> _banners = [];

  @override
  Widget build(BuildContext context) {
    return _buildBanner();
  }

  @override
  void initState() {
    super.initState();
    getBanner();
  }

  getBanner() async {
    await HttpMethods.getInstance().getBanner().then((result) {
      setState(() {
        if (result.data.length <= 0) return;
        _banners.clear();
        _banners.addAll(result.data);
      });
    });
    return _banners;
  }

  //轮播图
  Widget _buildBanner() {
    //一定要设置高度，不然就报如下错误
    //RenderRepaintBoundary#2f440 relayoutBoundary=up2 NEEDS-PAINT
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
    return Container(
      height: screenWidth * 500 / 900,
      width: screenWidth,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage.assetNetwork(
                placeholder: '',
                image: _banners[index]?.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: _banners?.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.lightBlue[50],
            activeColor: Colors.blue,
            size: 8,
          ),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        //没有请求到数据时设置为不自动播放，否则会连续快速滚动
        autoplay: _banners.isNotEmpty,
        autoplayDelay: 5000,
        loop: true,
        onTap: (int index) {
          NavigatorUtil.navigatorWeb(
              context, _banners[index]?.url, _banners[index]?.title);
        },
      ),
    );
  }
}
