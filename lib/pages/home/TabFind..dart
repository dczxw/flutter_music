import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/models/BannerBean.dart';
import 'package:music/models/banners.dart';

import 'components/BannerView.dart';
import 'components/NewSong.dart';
import 'components/RecommendView.dart';
import 'components/TopicView.dart';

class TabFind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabFindPage();
  }
}

class TabFindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }
}

class TabPageState extends State<TabFindPage> with AutomaticKeepAliveClientMixin {
  PageController controller = new PageController();

  List<Banners> bannerList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil.getInstance().setHeight(372),
                alignment: Alignment.topLeft,
                child: BannerView(dataList: bannerList),
              ),
              TopicView(),
              RecommendView(type: 0),
              NewSongView(),
            ],
          )),
    ));
  }

  loadData() async {
    BannerBean response = await Got.init().getBanner(2);
    setState(() {
      bannerList = response.banners;
    });
    print(response.banners);
  }


  @override
  bool get wantKeepAlive => true;
}
