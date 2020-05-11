import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/Constants.dart';
import 'package:music/common/Global.dart';
import 'package:music/common/SpUtils.dart';
import 'package:music/common/Utils.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/theme/Theme.dart';
import 'package:music/widget/RoundImage.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String username = "";
  String avatar = Global.avatar;
  String avatarBg = Global.avatarBg;

  @override
  void initState() {
    super.initState();
    if (!FUtils.isEmpty(Global.username)) {
      setState(() {
        username = Global.username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Container(
            color: RedTheme.colorFFFFFF,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 40, bottom: 20),
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(color: Colors.white, image: DecorationImage(image: buildImageBg(), fit: BoxFit.fill)),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            buildImage(),
                            Text(username, style: TextStyle(color: RedTheme.colorFFFFFF, fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      buildRow(0),
                      buildRow(1),
                      buildRow(2),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: FlatButton(
                    color: RedTheme.primaryColor,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "退   出",
                        style: TextStyle(color: RedTheme.colorFFFFFF),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      this.logout();
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildImage() {
    if (FUtils.isEmpty(avatar)) {
      return CircleAvatar(
        backgroundImage: AssetImage("images/login_logo.jpg"),
        backgroundColor: RedTheme.colorFFFFFF,
        radius: 40,
      );
    }
    return CircleAvatar(
      backgroundImage: NetworkImage(avatar),
      backgroundColor: RedTheme.colorFFFFFF,
      radius: 40,
    );
  }

  NetworkImage buildImageBg() {
    if (!FUtils.isEmpty(avatarBg)) {
      return NetworkImage(avatarBg);
    }
    return NetworkImage("https://p4.music.126.net/_f8R60U9mZ42sSNvdPn2sQ==/109951162868126486.jpg");
  }

  void logout() {
    Global.clearUser();
    Navigator.of(context).pushNamedAndRemoveUntil(
      'login',
      (route) => route == null,
    );
  }

  buildRow(int type) {
    var nameList = ['我的收藏',"我的评论","我的文章"];
    var iconList = [Icons.favorite,Icons.comment,Icons.book];

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 50,top: 15,bottom: 15,right: 20),
        child: Row(
          children: <Widget>[
            Icon(iconList[type],color: RedTheme.primaryColor,),
            Padding(
              child: Text(nameList[type],style: TextStyle(
                  fontSize: 16
              )),
              padding: EdgeInsets.only(left: 15),
            )
          ],
        ));
  }
}
