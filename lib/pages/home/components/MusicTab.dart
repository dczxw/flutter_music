import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/Constants.dart';
import 'package:music/common/api/HttpManager.dart';
import 'package:music/common/event/EventBus.dart';

class MusicPlayer extends StatefulWidget {
  MusicPlayer();

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  String id;

  @override
  void initState() {
    super.initState();
    bus.on(Constant.CHANGE_SONG, onSongChange);
  }

  void onSongChange(arg) {
    print("===============>>>>"+arg);
  }

  @override
  Widget build(BuildContext context) {
    id = "347230";

    return FutureBuilder(
      future: HttpManager.init().get("/song/detail", {"ids": id}),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          var songs = response.data["songs"];
          var picUrl = songs[0]['al']['picUrl'];
          var title = songs[0]['al']['name'];

          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(picUrl),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ))
                  ],
                ),
              ),
              Listener(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: 28,
                      height: 28,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(14))),
                    )),
                onPointerDown: (e) {
                  AudioPlayer audioPlayer = AudioPlayer();
                  var songURL = "https://music.163.com/song/media/outer/url?id=${id}.mp3";
                  audioPlayer.play(songURL);
                },
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 28,
                  ))
            ],
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
