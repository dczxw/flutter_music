import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/common/api/HttpManager.dart';
import 'package:music/common/event/Message.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/RoundImage.dart';
import 'package:provider/provider.dart';

class DayTopicPage extends StatefulWidget {
  @override
  _DayTopicPageState createState() => _DayTopicPageState();
}

class _DayTopicPageState extends State<DayTopicPage> {
  List list = [];

  @override
  void initState() {
    HttpManager.init().get("/login/cellphone", {'phone': '13386523365', 'password': '19921115dc'}).then(this.loginResponse);
    HttpManager.init().get("/recommend/songs", {"q": "id"}).then(this.response);
    super.initState();
  }

  void loginResponse(result) {
    print(result);
  }

  void response(result) {
    setState(() {
      list = result.data['recommend'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('今日推荐'),
              background: Image.asset(
                "images/day_bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          buildContent2()
        ],
      ),
    );
  }

  buildContent2() {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: new SliverGrid(
        //Grid
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, //Grid按两列显示
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 6.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var title = "-";
            var artist = "-";
            int id = 0;
            var image = "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4";
            if (list.length > 0) {
              var item = list[index];
              title = item['name'];
              image = item['album']['picUrl'];
              id = item['id'];
              artist = item['artists'][0]['name'];
              return new Container(
                height: ScreenUtil.getInstance().setHeight(120),
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  children: <Widget>[
                    RoundImage(
                      width: ScreenUtil.getInstance().setHeight(120),
                      height: ScreenUtil.getInstance().setHeight(120),
                      url: image,
                    ),
                    Text("   "),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            child: Text(title),
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(artist)
                        ],
                      ),
                    ),
                   Listener(
                     child:  Container(
                       width: 28,
                       height: 28,
                       child: Icon(
                         Icons.play_arrow,
                         color: RedTheme.color999999,
                         size: 20,
                       ),
                       decoration: BoxDecoration(border: Border.all(color: RedTheme.colorE6E6E6), borderRadius: BorderRadius.all(Radius.circular(14))),
                     ),
                     onPointerDown: (e){
                       Provider.of<MessageState>(context, listen: false).updateMsgType(id);
                       Navigator.pop(context);
                     },
                   )
                  ],
                ),
              );
            } else {
              return Text("");
            }
          },
          childCount: list.length,
        ),
      ),
    );
  }
}
