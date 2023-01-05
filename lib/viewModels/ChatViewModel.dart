import 'package:CatCultura/models/ChatMessage.dart';
import 'package:CatCultura/repository/ChatRepository.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/shared.dart';

import '../data/response/apiResponse.dart';
import '../utils/Session.dart';

class ChatViewModel with ChangeNotifier {

  final _chatRepo = ChatRepository();
  final session = Session();
  String? currentEvent;

  ChatViewModel(String eventId) {
    currentEvent = eventId;
    _chatRepo.subscribe(currentEvent!, this);
    _chatRepo.subscribeToEvent(currentEvent!);
  }

  void init(String eventId) {

    currentEvent = eventId;
    _chatRepo.subscribe(currentEvent!, this);
    _chatRepo.subscribeToEvent(currentEvent!);
  }


  ApiResponse<List<ChatMessage>> eventChatMessages = ApiResponse.loading();

  setChatList(ApiResponse<List<ChatMessage>> response){
    eventChatMessages = response;
    if (eventChatMessages.data != null) {
      eventChatMessages.data!.sort(
              (a,b) =>
                b.timeSent.compareTo(a.timeSent)
    );
    }
    // = eventChatMessages.data!.reversed.toList();
    notifyListeners();
  }


  void update(ChatMessage message) {
    eventChatMessages.data!.insert(0,message);
    notifyListeners();
  }


  Future<void> fetchMessages() async {
      await _chatRepo.getEventMessages(currentEvent!).then((value) {
        setChatList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setChatList(ApiResponse.error(error.toString())));

    }

  void sendMessage(String content) {
    Map<String, dynamic> message = {
      'userName': Session().data.username,
      'content': content,
      'eventId': currentEvent
    };
    _chatRepo.send(message);
    notifyListeners();
  }

  @override
  void dispose() {
    _chatRepo.unsubscribe(currentEvent!, this);
    super.dispose();
  }

}

