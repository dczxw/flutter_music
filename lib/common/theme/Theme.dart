import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedTheme {
  static var primaryColor = const Color(0xFFFF2C55);
  static var topicColor = const Color(0xFFFF1E13);
  static var colorFFFFFF = const Color(0xFFFFFFFF);
  static var color333333 = const Color(0xFF333333);
  static var color999999 = const Color(0xFF999999);
  static var colorE6E6E6 = const Color(0xFFE6E6E6);
  static var colorDC2C1F = const Color(0xFFDC2C1F);
}

// iOS浅色主题
final ThemeData kIOSTheme = ThemeData(
    brightness: Brightness.light,
    //亮色主题
    accentColor: Colors.white,
    //(按钮)Widget前景色为白色
    primaryColor: Colors.blue,
    //主题色为蓝色
    iconTheme: IconThemeData(color: Colors.grey),
    //icon主题为灰色
    textTheme: TextTheme(body1: TextStyle(color: Colors.black)) //文本主题为黑色
    );

// Android深色主题
final ThemeData kAndroidTheme = ThemeData(
    brightness: Brightness.dark,
    //深色主题
    accentColor: Colors.black,
    //(按钮)Widget前景色为黑色
    primaryColor: Colors.cyan,
    //主题色Wie青色
    iconTheme: IconThemeData(color: Colors.blue),
    //icon主题色为蓝色
    textTheme: TextTheme(body1: TextStyle(color: Colors.red)));
