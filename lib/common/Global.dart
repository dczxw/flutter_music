

import 'package:music/common/Constants.dart';
import 'package:music/common/SpUtils.dart';

import 'Log.dart';

class Global {

  static String token;
  static String avatar;
  static String avatarBg;
  static String username;

  // 可选的主题列表

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    token = await SpUtils.getString(Constant.SP_TOKEN);
    avatar = await SpUtils.getString(Constant.SP_AVATAR);
    username = await SpUtils.getString(Constant.SP_NAME);
  }

  static void saveUser(String token,String username,String avatar,String avatarBg){
    Global.token = token;
    Global.username = username;
    Global.avatar = avatar;
    Global.avatarBg = avatarBg;

    SpUtils.putString(Constant.SP_TOKEN, Global.token);
    SpUtils.putString(Constant.SP_NAME, Global.username);
    SpUtils.putString(Constant.SP_AVATAR, Global.avatar);
    SpUtils.putString(Constant.SP_AVATAR, Global.avatarBg);
  }

  static void clearUser(){
   SpUtils.remove(Constant.SP_AVATAR);
   SpUtils.remove(Constant.SP_NAME);
   SpUtils.remove(Constant.SP_TOKEN);
   SpUtils.remove(Constant.SP_AVATAR_BG);

   Global.token = "";
   Global.username = "";
   Global.avatar = "";
   Global.avatarBg = "";

  }

}