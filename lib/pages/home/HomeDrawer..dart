import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/RoundImage.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String username = "";
  String avatar = "https://p3.music.126.net/ma8NC_MpYqC-dK_L81FWXQ==/109951163250233892.jpg";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Container(
            color: RedTheme.color333333,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 50,bottom: 20),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                    backgroundColor: RedTheme.colorFFFFFF,
                    radius: 40,
                  ),
                ),
                Text(username,style: TextStyle(
                  color: RedTheme.colorFFFFFF,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ))
              ],
            ),
          )),
    );
  }

  void loadData() async {
    var userInfo = await Got.init().loginPhone("13386523365", "19921115dc");
    Map<String,dynamic> profile = userInfo['profile'];
    var nickname = profile['nickname'];
    var avatarUrl = profile['avatarUrl'];
    setState(() {
      username = nickname;
      avatar = avatarUrl;
    });
  }
}
