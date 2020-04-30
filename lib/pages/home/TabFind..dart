import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/common/api/HttpManager.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
          scrollDirection:Axis.vertical,
        child:  DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                FutureBuilder(
                    future: HttpManager.init().get("/banner", {"type": "1"}),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Response response = snapshot.data;
                        var bannerList = response.data["banners"];
                        //发生错误
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Container(
                          height: ScreenUtil.getInstance().setHeight(372),
                          alignment: Alignment.topLeft,
                          child: BannerView(dataList: bannerList),
                        );
                      }
                      return Text("");
                    }),
                TopicView(),
                RecommendView(type:0),
                NewSongView(),
              ],
            )),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}



