

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{

  static void putString(String key,String value) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString(key, value);
 }

 static void putInt(String key,int value) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setInt(key, value);
 }

 static void putBool(String key,bool value) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool(key, value);
 }

  static Future<String> getString(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    return value;
  }

  static Future<int> getInt(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key);
    return value;
  }

  static Future<bool> getBool(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key);
    return value;
  }

  static void remove(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}