import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/common/Utils.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/theme/Theme.dart';

class RecommendView extends StatelessWidget {

  final int type;

  RecommendView({Key key, this.type}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var title = "推荐歌单";


    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(title,
                    style:
                    TextStyle(fontSize: ScreenUtil.getInstance().setSp(45),
                        fontWeight: FontWeight
                        .bold)),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  height: 28.0,
                  alignment: Alignment.center,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: RedTheme.colorE6E6E6, width: 1.0),
                  ),
                  child: Text("查看更多",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: RedTheme.color333333)),
                ))
          ],
        ),
        FutureBuilder(
            future: Got.init().get("/personalized", {"limit": "10"}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                var resultList = response.data["result"];
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Container(
                  height: ScreenUtil.getInstance().setHeight(460),
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var obj = resultList[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil.getInstance().setHeight(30),
                            ScreenUtil.getInstance().setHeight(20),
                            ScreenUtil.getInstance().setHeight(20),
                            0),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  width: ScreenUtil.getInstance().setWidth(300),
                                  height: ScreenUtil.getInstance().setHeight(300),
                                  imageUrl: obj['picUrl'],
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                Positioned(
                                  child: Text(FUtils.init().formatNumber(obj['playCount']) + " ",style: TextStyle(color: Colors.white)),
                                  right: 0,
                                )

                              ],
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(300),
                              child: Text(
                                obj['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Text("");
            }),
      ],
    );
  }
}
