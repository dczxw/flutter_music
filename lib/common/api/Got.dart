import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/common/Global.dart';
import 'package:music/models/BannerBean.dart';
import 'package:music/models/UserInfo.dart';

import '../Utils.dart';

const HOST = "http://207.148.10.213:3000";

class Got {
  static Got inst;
  BuildContext context;
  Options _options;

  Got([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://207.148.10.213:3000',
    headers: {HttpHeaders.acceptHeader: "application/json"},
  ));

  static Got init() {
    if (inst == null) {
      inst = new Got();
    }
    List<Cookie> cookies = [
      new Cookie("MUSIC_U", "fdbe576e089bddf3140235363ed16bea4d5e10941815c4cd28fbda9117054ad75ad049b3f4421dca5fc356a7d408c9417955a739ab43dce1"),
      new Cookie("location", "china")
    ];
    var cj = new CookieJar();
    //Save cookies
    cj.saveFromResponse(Uri.parse(HOST), cookies);
    dio.interceptors.add(CookieManager(cj));

    return inst;
  }

  get(String url, dynamic queryParameters) {
    Dio _dio = new Dio();
    List<Cookie> cookies = [
      new Cookie("MUSIC_U", "fdbe576e089bddf3140235363ed16bea4d5e10941815c4cd28fbda9117054ad75ad049b3f4421dca5fc356a7d408c9417955a739ab43dce1"),
      new Cookie("location", "china")
    ];
    var cj = new CookieJar();
    //Save cookies
    cj.saveFromResponse(Uri.parse(HOST), cookies);
    _dio.interceptors.add(CookieManager(cj));
    var reqUrl = HOST + url;
    print(reqUrl);
    return _dio.get(reqUrl, queryParameters: queryParameters);
  }

  Future<BannerBean> getBanner(int type) async {
    var resp = await dio.get("/banner", queryParameters: {"type": type}, options: _options);
    print(resp.toString());
    return BannerBean.fromJsonMap(resp.data);
  }

  Future<Object> getSongDetail(String id) async {
    var resp = await dio.get("/song/detail", queryParameters: {"ids": id}, options: _options);
    return resp;
  }

  Future<UserInfo> loginPhone(
    String username,
    String password,
  ) async {
    var resp = await dio.get("/login/cellphone", queryParameters: {"phone": username, "password": password}, options: _options);
    if (resp.data['code'] == 200) {
      return UserInfo.fromJson(resp.data);
    } else {
      FUtils.toast(resp.data['msg']);
    }
  }

  Future<Map<String, dynamic>> loginEmail(String username, String password) async {
    var resp = await dio.get("/login", queryParameters: {"email": username, "password": password}, options: _options);
    return resp.data;
  }

  Future<Map<String, dynamic>> getSongSheet() async {
    var resp = await dio.get("/user/playlist", queryParameters: {"uid": Global.userId}, options: _options);
    print(resp.toString());
    return resp.data;
  }
}
