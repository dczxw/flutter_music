import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music/common/api/HttpManager.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/RoundImage.dart';


class NewSongView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewSongPage();
  }
}



class NewSongPage extends StatefulWidget {
  @override
  _NewSongViewState createState() => _NewSongViewState();
}

class _NewSongViewState extends State<NewSongPage> {
  @override
  Widget build(BuildContext context) {
    var title = "新歌";
    var title2 = "新碟";

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Listener(
                child: Text(title,
                  style: TextStyle(
                    color: RedTheme.color333333,
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontWeight: FontWeight.bold)
                ),
                onPointerDown: (event) {
                  pointClick(1);
                },
              )
            ),
            Text("|"),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Listener(
                child: Text(title2,
                  style: TextStyle(
                    color: RedTheme.color999999,
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontWeight: FontWeight.bold)),
                onPointerDown: (e) {
                  pointClick(2);
                },
              )
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                alignment: Alignment.topRight,
                child: Container(
                  height: 28.0,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(14.0),
                    border:
                    Border.all(color: RedTheme.colorE6E6E6, width: 1.0),
                  ),
                  child: Text("查看更多",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: RedTheme.color333333)),
                )),
            )
          ],
        ),
        FutureBuilder(
          future: HttpManager.init()
            .get("/personalized/newsong", {"limit": "10"}),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              var resultList = response.data["result"];
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              return Container(
                height: ScreenUtil.getInstance().setHeight(600),
                child: Swiper(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  autoplay: false,
                  itemBuilder: (c, i) {
                    var li = [
                      resultList[0 + i * 3],
                      resultList[1 + i * 3],
                      resultList[2 + i * 3]
                    ];

                    return Container(
                      margin: EdgeInsets.fromLTRB(
                        ScreenUtil.getInstance().setWidth(48),
                        ScreenUtil.getInstance().setWidth(0),
                        ScreenUtil.getInstance().setWidth(48),
                        ScreenUtil.getInstance().setWidth(0)),
                      //卡片大小
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: 3,
                        itemExtent: ScreenUtil.getInstance()
                          .setHeight(200), //强制高度为50.0
                        itemBuilder: (BuildContext context, int index) {
                          var obj = li[index];
                          return Row(
                            children: <Widget>[
                              RoundImage(
                                url:li[index]["picUrl"],
                                width:ScreenUtil.getInstance().setHeight(160)),
                              Text("  "),
                              Text(
                                li[index]['name'],
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance()
                                    .setSp(40),
                                  color: RedTheme.color333333),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance()
                                    .setSp(40),
                                  color: RedTheme.color999999),
                              ),
                              Text(
                                obj['song']['artists'][0]['name'],
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance()
                                    .setSp(32),
                                  color: RedTheme.color999999),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil.getInstance().setWidth(72),
                                    height: ScreenUtil.getInstance().setHeight(72),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: RedTheme.color999999)),
                                    child: Icon(Icons.play_arrow,color: Colors.red,size: 20,)
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              )
                            ],
                          );
                        }),
                    );
                  },
                ));
            }
            return Text("");
          }),
      ],
    );
  }

  void pointClick(int index) {
//    setState(() {
//      flag = index;
//    });
  }
}

