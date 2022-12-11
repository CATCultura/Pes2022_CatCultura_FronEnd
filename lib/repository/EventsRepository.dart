//import 'dart:html';

import 'dart:math';

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


  Future<List<EventResult>> getRutaCultural(double longitud, double latitud, double radio) async {
    // try{
    //   dynamic response = await _apiServices.getGetApiResponse("${baseUrl}xxxxxxx");
    //   List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
    //   //_cachedEvents = res;
    //   return res;
    // } catch(e){
    //   rethrow;
    // }
    //41.3874, 2.1686

    try {
      final random = new Random();
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events?page=${random.nextInt(10)}&size=3"); //no va --> &sort=$sort
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      return res;

    } catch (e) {
      rethrow;
    }
    // await Future.delayed(const Duration(seconds: 2));
    // return [EventResult(id: "1", denominacio: "e1",longitud:41.3872, latitud: 2.1684),EventResult(id: "2", denominacio: "e2",longitud:41.3870, latitud: 2.1682),EventResult(id: "3", denominacio: "e3",longitud:41.3868, latitud: 2.1680)];
  }

  Future<List<String>> getTags() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}tags");
      List<String> tagsAmbits = (response['ambits'] as List).map((item) => item as String).toList();
      List<String> tagsAmbitsCateg = (response['altresCategories'] as List).map((item) => item as String).toList();
      List<String> tagsAltresCateg = (response['categories'] as List).map((item) => item as String).toList();
      List<String> res = [tagsAmbits, tagsAmbitsCateg, tagsAltresCateg].expand((x) => x).toList();
      return res;

    } catch (e) {
      rethrow;
    }
  }
}