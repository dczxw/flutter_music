import 'package:dio/dio.dart';

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
    return _dio.get(HOST + url, queryParameters: param);
  }
}
