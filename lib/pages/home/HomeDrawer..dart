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

  @override
  void initState() {
    super.initState();
    if (!FUtils.init().isEmpty(Global.username)) {
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
            color: RedTheme.color333333,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 50, bottom: 20),
                        alignment: Alignment.center,
                        child: buildImage(),
                      ),
                      Text(username,
                          style: TextStyle(
                              color: RedTheme.colorFFFFFF,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                FlatButton(
                  color: RedTheme.colorFFFFFF,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "退   出",
                      style: TextStyle(color: RedTheme.primaryColor),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    this.logout();
                  },
                )
              ],
            ),
          )),
    );
  }

  Widget buildImage() {
    if (FUtils.init().isEmpty(avatar)) {
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

  void logout() {
    Global.clearUser();
    Navigator.pushNamed(context, "login");
  }
}
