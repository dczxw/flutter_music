import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/Log.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/RoundImage.dart';

class TabPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabPersonPage();
  }
}

class TabPersonPage extends StatefulWidget {
  @override
  _TabPersonState createState() => _TabPersonState();
}

class _TabPersonState extends State<TabPersonPage> with AutomaticKeepAliveClientMixin {
  var dataList = [
    {"name": "我的收藏", "icon": Icons.favorite_border, "color": RedTheme.primaryColor},
    {"name": "我的关注", "icon": Icons.center_focus_weak, "color": RedTheme.colorPurple},
    {"name": "我的电台", "icon": Icons.radio, "color": RedTheme.colorBlack},
    {"name": "我的评论", "icon": Icons.comment, "color": RedTheme.colorGreenAccent},
    {"name": "我的动态", "icon": Icons.share, "color": RedTheme.colorBlueAccent},
    {"name": "我的粉丝", "icon": Icons.supervised_user_circle, "color": RedTheme.colorPinkAccent},
  ];
  var playlist = [];

  initState() {
    this.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RedTheme.colorE6E6E6,
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTop(),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              color: RedTheme.colorFFFFFF,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 20),
              height: 40,
              child: Text("我的歌单", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            buildSong(),
          ],
        ),
      ),
    );
  }

  dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  buildTop() {
    return Container(
      color: RedTheme.colorFFFFFF,
      padding: EdgeInsets.only(bottom: 20),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 1.5 //显示区域宽高相等
              ),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            var item = dataList[index];

            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Icon(
                    item['icon'],
                    color: item['color'],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(item['name']),
                  ),
                ],
              ),
            );
          }),
    );
  }

  buildSong() {
    if (playlist.length > 0) {
      return Container(
        color: RedTheme.colorFFFFFF,
        padding: EdgeInsets.only(bottom: 20),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //每行三列
                childAspectRatio: 3 //显示区域宽高相等
                ),
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              var item = playlist[index];
              var coverImgUrl = item['coverImgUrl'];

              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    RoundImage(
                      width: 20,
                      height: 20,
                      url: coverImgUrl,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(item['name']),
                    ),
                  ],
                ),
              );
            }),
      );
    } else {
      return Text("!!!!");
    }
  }

  loadData(){
    Got.init().getSongSheet().then(this.callback);
  }

  callback(dynamic resp) {
    Log.d("AAAAA", resp.toString());
    var playlist = resp['playlist'];
    setState(() {
      playlist = playlist;
    });
  }
}
