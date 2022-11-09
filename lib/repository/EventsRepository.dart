
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
      _cachedEvents = res;

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
  Future<List<EventResult>> getAttendanceByUserId(String id) async {
    try{
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}user/$id/attendance");
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      //_cachedEvents = res;
      return res;
    } catch(e){
      rethrow;
    }
  }

  Future<List<EventResult>> getFavouritesByUserId(String id) async {
    try{
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/$id/favourites");
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      //_cachedEvents = res;
      return res;
    } catch(e){
      rethrow;
    }
  }

  Future<String> addFavouriteByUserId(String id, int eventId) async {
    try{
      dynamic response = await _apiServices.getPutApiResponse("${baseUrl}users/$id/favourites/$eventId", "" );
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> deleteFavouriteByUserId(String id, int eventId) async{
    try{
      dynamic response = await _apiServices.getDeleteApiResponse("${baseUrl}users/$id/favourites/$eventId", "");
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> addAttendanceByUserId(String id, int eventId) async {
    try{
      dynamic response = await _apiServices.getPutApiResponse("${baseUrl}users/$id/attendance/$eventId", "");
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }

  }

  Future<String> deleteAttendanceByUserId(String id, int eventId) async{
    try{
      dynamic response = await _apiServices.getDeleteApiResponse("${baseUrl}users/$id/assistance/$eventId", "");
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }




}