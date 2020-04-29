import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/common/api/HttpManager.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/VideoPlayerPage.dart';

class TabVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: TabVideoPage(),
    );
  }
}

class TabVideoPage extends StatefulWidget {
  @override
  _TabPersonState createState() => _TabPersonState();
}

class _TabPersonState extends State<TabVideoPage> {
  Animation<double> animation;
  AnimationController controller;

  var titleList = [""];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 4,
        child: new Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              backgroundColor: Colors.white,
              title: new TabBar(
                isScrollable: false,
                indicatorColor: Colors.red,
                labelColor: Colors.red,
                labelStyle: TextStyle(
                  fontSize: 13.0,
                ),
                tabs: <Widget>[
                  Tab(
                    text: '全部',
                  ),
                  Tab(text: '推荐'),
                  Tab(text: '最新'),
                  Tab(text: '网易出品'),
                ],
              ),
            ),
            body: Container(
              color: RedTheme.colorFFFFFF,
              child: new TabBarView(
                children: <Widget>[
                  MvPage(),
                  Text("1111"),
                  Text("1111"),
                  Text("1111"),
                ],
              ),
            )));
  }

  dispose() {
    //路由销毁时需要释放动画资源
    super.dispose();
  }
}

class MvPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpManager.init().get("/mv/all", {"limit": 15, "area": '内地'}),
        builder: (BuildContext c, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            var respList = response.data['data'];
            return ListView.separated(
                itemCount: respList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    color: RedTheme.colorE6E6E6,
                    width: double.infinity,
                    height: 8,
                  );
                },
                itemBuilder: (c, i) {
                  var item = respList[i];
                  var imgUrl = item['cover'];
                  var name = item['name'];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Column(
                      children: <Widget>[
                        VideoCard(item,imgUrl),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(name, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(48))),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: Image.network(imgUrl,fit: BoxFit.fill),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
          return Text("");
        });
  }

  buildVideoCard(imgUrl, item) async {
    return FutureBuilder(
        future: HttpManager.init().get("/mv/url", {"id": item['id']}),
        builder: (BuildContext c, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            var result = response.data['data'];
            return VideoPlayerPage(
              url: imgUrl,
              item: result,
            );
          }
          return Container();
        });
  }
}

class VideoCard extends StatelessWidget {
  var url;
  var item;

  VideoCard(item, url) {
    this.url = url;
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpManager.init().get("/mv/url", {"id": item['id']}),
        builder: (BuildContext c, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            var result = response.data['data'];
            return VideoPlayerPage(
              url: url,
              item: result,
            );
          }
          return Container();
        });
  }
}
