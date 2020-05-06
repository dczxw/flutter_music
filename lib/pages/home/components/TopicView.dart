import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/theme/Theme.dart';

class TopicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildTopic(context),
    );
  }

  List<Widget> buildTopic(BuildContext context) {
    List<Widget> list = new List();

    var now = DateTime.now();

    list.add(buildTopicItem(context,"每日推荐", "images/t_dragonball_icn_daily.png", "" + now.day.toString()));
    list.add(buildTopicItem(context,"歌单", "images/t_dragonball_icn_playlist.png", ""));
    list.add(buildTopicItem(context,"排行榜", "images/t_dragonball_icn_rank.png", ""));
    list.add(buildTopicItem(context,"电台", "images/t_dragonball_icn_radio.png", ""));
    list.add(buildTopicItem(context,"直播", "images/t_dragonball_icn_look.png", ""));

    return list;
  }

  Widget buildTopicItem(BuildContext context,String name, String url, String centerText) {
    return Expanded(
      flex: 1,
      child: Listener(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  new CircleAvatar(
                    radius: 20,
                    backgroundColor: RedTheme.topicColor,
                    backgroundImage: AssetImage(url),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(centerText, style: TextStyle(color: RedTheme.topicColor, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Text(name)
          ],
        ),
        onPointerDown: (e) {
          Navigator.pushNamed(context,"day_topic_page");
        },
      ),
    );
  }
}
