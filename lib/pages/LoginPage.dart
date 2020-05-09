import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/common/Constants.dart';
import 'package:music/common/Global.dart';
import 'package:music/common/Log.dart';
import 'package:music/common/SpUtils.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/theme/Theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _upasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: RedTheme.colorDC2C1F,
        alignment: Alignment.center,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.only(left: 30, top: 100, right: 30),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage("images/login_logo.jpg"),
                backgroundColor: RedTheme.colorFFFFFF,
                radius: 40,
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: RedTheme.colorFFFFFF),
                child: TextField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入手机号码或邮箱",
                      hintStyle: TextStyle(color: RedTheme.color999999),
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 20, bottom: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: RedTheme.colorFFFFFF),
                child: TextField(
                  controller: _upasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入登录密码",
                      hintStyle: TextStyle(color: RedTheme.color999999),
                      prefixIcon: Icon(Icons.lock)),
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
                    "登   录",
                    style: TextStyle(color: RedTheme.primaryColor),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  this.submit();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    String username = _unameController.text.toString();
    String password = _upasswordController.text.toString();

    if (username.contains("@")) {
    } else {
      Got.init().loginPhone(username, password).then(this.loginSuccess);
    }
  }

  void loginSuccess(res) {
    if (res['code'] == 200) {
      Global.saveUser(res["token"], res["profile"]['nickname'], res["profile"]['avatarUrl']);
      Navigator.pushNamed(context, "home");
    } else {
      Fluttertoast.showToast(
        msg: res['msg'],
        toastLength: Toast.LENGTH_SHORT,
        webBgColor: "#e74c3c",
        timeInSecForIosWeb: 5,
      );
    }
  }
}
