import 'package:CatCultura/models/SessionResult.dart';


class Session {
  Session._privateConstructor();
  static final Session _instance = Session._privateConstructor();
  static Map<String, dynamic> sessionData = {};
  factory Session() {
    return _instance;
  }

  SessionResult data = SessionResult(id: -1, username: "Anonymous", role: "x", hash: "x");

  dynamic set(String key, dynamic value) {
    sessionData[key] = value;
  }

  bool has(String key){
    if(sessionData.containsKey(key)) return true;
    return false;
  }

  dynamic get(String key) {
    if (sessionData.containsKey(key)) {
      return sessionData[key];
    } else {
      return null;
    }
  }

  void deleteSession() {
    data = SessionResult(id: -1, username: "Anonymous", role: "x", hash: "x");
    sessionData = {};
  }
}