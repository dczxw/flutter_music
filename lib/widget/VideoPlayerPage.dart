import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;
  final Object item;

  VideoPlayerPage({Key key, this.item, this.url}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState(item, url);
}

class _VideoPlayerState extends State<VideoPlayerPage> with AutomaticKeepAliveClientMixin {
  String url;
  var item;
  VideoPlayerController _controller;

  Dio dio = Dio();

  _VideoPlayerState(item, String u) {
    this.url = u;
    this.item = item;
  }

  @override
  Future<void> initState() {
    super.initState();
    var videoURL = item['url'];
    if (videoURL.startsWith("http://")) {
      videoURL = videoURL.replaceFirst("http://", "https://");
    }
    _controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return showCard();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget showCard() {
    if (_controller.value.initialized) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        width: double.infinity,
        height: ScreenUtil.getInstance().setHeight(560),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            VideoPlayer(_controller),
            Listener(
              child:  buildIcon(),
              onPointerDown: (e){
                if(!_controller.value.isPlaying ){
                  _controller.play();
                }else{
                  _controller.pause();
                }
              },
            )

          ],
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
      );
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(560),
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  buildIcon() {
    if( _controller.value.isPlaying){
      return Icon(Icons.play_arrow ,color: Colors.transparent,size: 0,);
    }

    return Icon(Icons.play_arrow,color: Colors.white,size: 36);
  }
}
