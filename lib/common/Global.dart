

import 'package:music/common/Constants.dart';
import 'package:music/common/SpUtils.dart';

import 'Log.dart';

class Global {

  static String token;
  static String avatar;
  static String avatarBg;
  static String username;
  static int userId;

  // 可选的主题列表

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    token = await SpUtils.getString(Constant.SP_TOKEN);
    avatar = await SpUtils.getString(Constant.SP_AVATAR);
    username = await SpUtils.getString(Constant.SP_NAME);
    avatarBg = await SpUtils.getString(Constant.SP_AVATAR_BG);
    userId = await SpUtils.getInt(Constant.SP_USER_ID);
  }

  static void saveUser(String token,String username,String avatar,String avatarBg,int userId){
    Global.token = token;
    Global.username = username;
    Global.avatar = avatar;
    Global.avatarBg = avatarBg;
    Global.userId = userId;

    SpUtils.putString(Constant.SP_TOKEN, Global.token);
    SpUtils.putString(Constant.SP_NAME, Global.username);
    SpUtils.putString(Constant.SP_AVATAR, Global.avatar);
    SpUtils.putString(Constant.SP_AVATAR_BG, Global.avatarBg);
    SpUtils.putInt(Constant.SP_USER_ID, Global.userId);
  }

  static void clearUser(){
   SpUtils.remove(Constant.SP_AVATAR);
   SpUtils.remove(Constant.SP_NAME);
   SpUtils.remove(Constant.SP_TOKEN);
   SpUtils.remove(Constant.SP_AVATAR_BG);
   SpUtils.remove(Constant.SP_USER_ID);

   Global.token = "";
   Global.username = "";
   Global.avatar = "";
   Global.avatarBg = "";
   Global.userId = 0;

  }

}