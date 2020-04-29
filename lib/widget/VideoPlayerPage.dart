import 'package:chewie/chewie.dart';
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

class _VideoPlayerState extends State<VideoPlayerPage> {
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
    return Listener(
      child: buildVideo(),
      onPointerDown: (e) {
        setState(() {
          _controller.value.isPlaying ? _controller.pause() : _controller.play();
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildVideo() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(560),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Container(
          width: double.infinity,
          child: VideoPlayer(_controller),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
