import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../data/network/networkApiServices.dart';
import '../models/ChatMessage.dart';
import '../utils/Session.dart';
import '../viewModels/ChatViewModel.dart';

class ChatRepository {
  final baseUrl = "http://40.113.160.200:8081/chat";
  final getMessagesUrl = "http://40.113.160.200:8081/messages/";
  // final baseUrl = "http://10.4.41.41:8081:8081/chat";
  // final getMessagesUrl = "http://10.4.41.41:8081/messages/";

  final NetworkApiServices _apiServices = NetworkApiServices();
  final session = Session();

  Map<String, ChatViewModel> observers = {};
  Map<String, dynamic> remoteSubscriptions = {};

  ChatRepository._privateConstructor();

  static final ChatRepository _instance = ChatRepository._privateConstructor();

  factory ChatRepository() {
    return _instance;
  }

  static bool connected = false;

  static void onConnectCallback(StompFrame frame) {
    connected = true;
  }

  static StompClient client = StompClient(
                        config: StompConfig(
                        url: "ws://40.113.160.200:8081/chat",
                          // url: "ws://10.4.41.41:8081/chat",
                          onConnect: onConnectCallback,
                        onWebSocketError: (dynamic error) => debugPrint(error.toString()),
                      ));

  void connect() {
    client.activate();
  }

  bool isConnected() {
    return connected;
  }


  void subscribe(String eventId, ChatViewModel viewModel) {
    observers[eventId]=viewModel;
  }

  ChatViewModel? getSubscriber(String eventId) {
    if (observers.containsKey(eventId)) return observers[eventId];
    return null;
  }

  void unsubscribe(String eventId, ChatViewModel viewModel) {
    if (remoteSubscriptions.containsKey(eventId)) {
      remoteSubscriptions[eventId]();
    }
    observers.remove(eventId);
  }

  void returnMessage(StompFrame frame) {
    // final codeUnits = frame.body?.codeUnits;
    // String text = const Utf8Decoder().convert(codeUnits!);
    dynamic res = jsonDecode(frame.body!);
    ChatMessage message = ChatMessage.fromJson(res);
    debugPrint("Received message ${message.content}");
    notifyObservers(message.eventId.toString(), message);
    //mostrar notificació
  }

  void subscribeToEvent(String eventId) {
    if (client.connected) {
      debugPrint("Connected and subscribing to event $eventId");
      remoteSubscriptions[eventId] = client.subscribe(destination: '/topic/messages/$eventId', callback: returnMessage);
    }
    debugPrint("not connected");
  }

  void notifyObservers(String string, ChatMessage message) {
    observers[string]?.update(message);
  }

  Future<List<ChatMessage>> getEventMessages(String s) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(getMessagesUrl+s);
      return List.from(response.map((e) => ChatMessage.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  void send(Map<String, dynamic> message) {
    client.send(destination: '/app/chat/${message['eventId']}', body: jsonEncode(message));
  }
}