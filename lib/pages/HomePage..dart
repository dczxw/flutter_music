import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/pages/home/TabPerson..dart';

import 'home/HomeDrawer..dart';
import 'home/TabFind..dart';
import 'home/TabVedio..dart';
import 'home/components/MusicTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    ScreenUtil.getInstance().init(context);


    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: new AppBar(
                title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new TabBar(
                    indicatorColor: Colors.transparent,
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    tabs: <Widget>[
                      Tab(text: '我的'),
                      Tab(text: '发现'),
                      Tab(text: '视频'),
                    ],
                  ),
                ),
                Padding(
                  child: Icon(Icons.search),
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                )
              ],
            )),
            drawer: HomeDrawer(),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new TabBarView(
                    children: <Widget>[
                     TabPerson(),
                      TabFind(),
                      TabVideo()
                    ],
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  color: Colors.red,
                  child: MusicPlayer()
                )
              ],
            )));
  }

}
