import 'package:music/common/Log.dart';

class UserInfo {
  String token;
  String nickname;
  String avatar;
  String avatarBg;
  int userId;

  @override
  String toString() {
    return 'UserInfo{token: $token, nickname: $nickname, avatar: $avatar, avatarBg: $avatarBg, userId: $userId}';
  }

  UserInfo(this.token, this.nickname, this.avatar, this.avatarBg, this.userId);

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    Log.d("tag", json['profile']['userId']);
    return UserInfo(json['token'], json['profile']['nickname'], json['profile']['avatar'], json['profile']['backgroundUrl'], json['profile']['userId']);
  }
}
