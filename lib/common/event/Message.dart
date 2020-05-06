import 'package:flutter/cupertino.dart';

class MessageState with  ChangeNotifier{

 int _msgType = 0;

  get msgType => _msgType;

  // 接口方法
  void updateMsgType(int _msgType) {
    this._msgType = _msgType;
    notifyListeners();
  }
}