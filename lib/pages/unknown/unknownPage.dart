import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404")
      ),
      body: Center(
        child: Text("错误的页面"),
      ),
    );
  }
}
