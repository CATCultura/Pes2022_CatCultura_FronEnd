import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/network/networkApiServices.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class EventsRepository {
  final baseUrl = "http://10.4.41.41:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();

  EventsRepository._privateConstructor();

  static final EventsRepository _instance = EventsRepository._privateConstructor();

  factory EventsRepository() {
    return _instance;
  }

  List<EventResult> _cachedEvents = [];

  Future<List<EventResult>> getEvents() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events");

      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      debugPrint("print del repositori"+res[0].toString());
      _cachedEvents = res;

      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventResult>> getEventsWithFilter(String filter) async {
    List<EventResult> res = [];
    for(EventResult e in _cachedEvents){
      debugPrint(e.denominacio != null? e.denominacio : "NO:NAME");
      if(e.denominacio!.contains(filter)) {
        res.add(e);
        debugPrint("added event: ${e.denominacio!}");
      }
    }
    return res;
    // try {
    //   dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events");
    //
    //   List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
    //   _cachedEvents = res;
    //
    //   return res;
    //
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<List<EventResult>> getEventsWithParameters(int? page, int? size, String? sort) async {
    //events?page=0&size=2&sort=string
    page ??= 0;
    size ??= 20;
    //sort ??= "string";
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events?page=$page&size=$size"); //no va --> &sort=$sort
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      return res;

    } catch (e) {
      rethrow;
    }
  }


  Future<EventResult> getEventById(String id) async {
    EventResult? cached = eventInCache(id);
    if(cached.id!= null) {
      debugPrint(cached.denominacio);
      return cached;
    }
    else{
      try {
        dynamic response = await _apiServices.getGetApiResponse(
            "${baseUrl}events/$id");
        return EventResult.fromJson(response);
      } catch (e) {
        rethrow;
      }
    }
  }

  EventResult eventInCache(String id){
    debugPrint("cached event");
    EventResult result = EventResult();
    for (var e in _cachedEvents) {
      if(e.id == id) result = e;
    }
    return result;
  }

}