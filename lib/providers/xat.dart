import 'package:flutter/cupertino.dart';

import '../models/Message.dart';

class XatProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}