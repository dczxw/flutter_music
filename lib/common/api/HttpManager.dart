import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

//const HOST = "http://106.13.224.88:3000";
const HOST = "http://207.148.10.213:3000";

class HttpManager {
  static HttpManager inst;

  static HttpManager init() {
    if (inst == null) {
      inst = new HttpManager();
    }

    return inst;
  }

  get(url, param) {
    Dio _dio = new Dio();
    List<Cookie> cookies = [new Cookie("MUSIC_U", "fdbe576e089bddf3140235363ed16bea4d5e10941815c4cd28fbda9117054ad75ad049b3f4421dca5fc356a7d408c9417955a739ab43dce1"),new Cookie("location", "china")];
    var cj = new CookieJar();
    //Save cookies
    cj.saveFromResponse(Uri.parse(HOST), cookies);
    _dio.interceptors.add(CookieManager(cj));
    return _dio.get(HOST + url, queryParameters: param);
  }
}
