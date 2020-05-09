

import 'package:music/common/Constants.dart';
import 'package:music/common/SpUtils.dart';

class Global {

  static String token;

  // 可选的主题列表

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
//    token = await SpUtils.getString(Constant.SP_TOKEN);
  }

}