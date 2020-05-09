class Log {
  static d(String tag, value) {
    print("========${tag} start===========");
    print(value.toString());
    print("========${tag} end===========");
  }
}
