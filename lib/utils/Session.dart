class Session {
  Session._privateConstructor();

  static final Session _instance = Session._privateConstructor();

  static Map<String, dynamic> sessionData = {};

  factory Session() {
    return _instance;
  }

  dynamic set(String key, dynamic value) {
    sessionData[key] = value;
  }

  dynamic get(String key) {
    if (sessionData.containsKey(key)) {
      return sessionData[key];
    } else {
      return null;
    }
  }
}