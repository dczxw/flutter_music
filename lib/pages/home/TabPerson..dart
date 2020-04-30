import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: TabPersonPage(),
    );
  }
}

class TabPersonPage extends StatefulWidget {
  @override
  _TabPersonState createState() => _TabPersonState();
}

class _TabPersonState extends State<TabPersonPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(()=>{});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: new Center(
        child: Image.asset("images/c52.png",
            width: animation.value,
            height: animation.value
        ),
      ),
      onPointerDown: (e){
        controller.forward();
      },
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
