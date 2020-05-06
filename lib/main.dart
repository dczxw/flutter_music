import 'package:flutter/material.dart';
import 'package:music/common/event/Message.dart';
import 'package:music/pages/HomePage..dart';
import 'package:provider/provider.dart';
import 'common/routers.dart';
import 'common/theme/Theme.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MessageState())],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '首页',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: RedTheme.primaryColor),
      home: HomePage(),
      routes: routers,
    );
  }
}
