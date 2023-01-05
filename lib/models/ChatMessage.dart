class ChatMessage {
  int eventId = -1;
  int messageId = -1;
  String userId = "";
  String username = "";
  String content = "";
  String timeSent = "";

  ChatMessage.fromJson(Map<String, dynamic> jsonResponse) {
    eventId = jsonResponse['eventId'] ?? -1;
    messageId = jsonResponse['id'] ?? -1;
    userId = jsonResponse['userId'] ?? "";
    username = jsonResponse['userName'] ?? "";
    content = jsonResponse['content'] ?? "";
    timeSent = jsonResponse['timeSent'] ?? "";

  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'id': messageId,
      'userId': userId,
      'userName': username,
      'content': content,
      'timeSent': timeSent.toString(),
    };
  }



}