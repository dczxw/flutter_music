import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/common/Constants.dart';
import 'package:music/common/Utils.dart';
import 'package:music/common/api/Got.dart';
import 'package:music/common/event/EventBus.dart';
import 'package:music/common/event/Message.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    id = "347230";

    return Consumer<MessageState>(
        builder: (context, categoryState, child){
          if(FUtils.init().isEmpty(categoryState.msgType.toString())){
            id = categoryState.msgType.toString();
          }
          return FutureBuilder(
            future: Got.init().get("/song/detail", {"ids": id}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                var songs = response.data["songs"];
                var picUrl = "";
                var title = "";
                if(songs.length>0){
                   picUrl = songs[0]['al']['picUrl'];
                   title = songs[0]['name'];
                }else{
                  picUrl = "https://p2.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg";
                }

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
    );

  }
}
