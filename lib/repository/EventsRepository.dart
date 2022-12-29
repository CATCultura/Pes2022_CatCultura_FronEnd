import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'dart:math';


import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/ReviewResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/network/networkApiServices.dart';
import 'package:CatCultura/models/ReviewResult.dart';

import '../utils/Session.dart';

// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class EventsRepository {
  final baseUrl = "http://10.4.41.41:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();
  final session = Session();

  EventsRepository._privateConstructor();

  static final EventsRepository _instance = EventsRepository._privateConstructor();

  factory EventsRepository() {
    return _instance;
  }

  List<EventResult> _cachedEvents = [];

  Future<List<EventResult>> getEvents() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events"); //40.113.160.200:8081
      // dynamic response = await _apiServices.getGetApiResponse("http://40.113.160.200:8081/events");
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      //debugPrint("print del repositori"+res[0].toString());
      _cachedEvents = res;

      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventResult>> getEventsWithFilter(String filter) async {
    // List<EventResult> res = [];
    // for(EventResult e in _cachedEvents){
    //   debugPrint(e.denominacio != null? e.denominacio : "NO:NAME");
    //   // if(e.denominacio!.contains(filter)) {
    //   //   res.add(e);
    //   //   debugPrint("added event: ${e.denominacio!}");
    //   // }
    // }
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events?q=$filter");
      debugPrint(filter);
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());

      return res;

    } catch (e) {
      rethrow;
    }
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
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/$id/attendance");
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
      dynamic response = await _apiServices.getDeleteApiResponse("${baseUrl}users/$id/attendance/$eventId", "");
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<EventResult> postCreaEvent(EventResult data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse("${baseUrl}events", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteEventId(String? eventId) async{
    try{
      dynamic response = await _apiServices.getDeleteApiResponse("${baseUrl}events/$eventId", "");
      String res = response;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addEventById(EventResult data) async {
    try{
      dynamic response = await _apiServices.getPutEventApiResponse("${baseUrl}events", data);
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }


  Future<List<EventResult>> getRutaCultural(double longitud, double latitud, int radio, String data) async {
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
      //dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events?page=${random.nextInt(10)}&size=3"); //no va --> &sort=$sort
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/generate_route?lat=41.375&lon=2.176&day=$data&userId=${session.data.id.toString()}&radius=$radio&discardedEvents=841");
      //debugPrint(response.toString());
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
  Future<List<ReviewResult>>getEventReviewsById(String id) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events/$id/reviews");
      List<ReviewResult> res = List.from(response.map((r) => ReviewResult.fromJson(r)).toList());
      //debugPrint("lista de reviews");
      // List<ReviewResult> res = [
      //   ReviewResult(title: "Title of review 1", user: "Juane Olivan", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at auctor dolor. Mauris varius tincidunt ante eu condimentum. In hac habitasse platea dictumst. Nunc ullamcorper nunc sed porta dignissim. Donec justo arcu, vehicula sit amet odio ac, tincidunt malesuada augue. Nullam sollicitudin mollis hendrerit. Suspendisse libero felis, imperdiet fermentum nunc eget, dictum iaculis tortor. Nam id odio neque. Proin aliquam a diam id aliquet. Maecenas at erat est. Nullam eu enim tortor. Suspendisse vel ex eget ligula luctus vehicula. Morbi sodales consequat sem, a tincidunt nisi semper vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      //   score: 5, date: "4-4-4"),
      //   ReviewResult(title: "Title of review 2", user: "Juane Olivan", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at auctor dolor. Mauris varius tincidunt ante eu condimentum. In hac habitasse platea dictumst. Nunc ullamcorper nunc sed porta dignissim. Donec justo arcu, vehicula sit amet odio ac, tincidunt malesuada augue. Nullam sollicitudin mollis hendrerit. Suspendisse libero felis, imperdiet fermentum nunc eget, dictum iaculis tortor. Nam id odio neque. Proin aliquam a diam id aliquet. Maecenas at erat est. Nullam eu enim tortor. Suspendisse vel ex eget ligula luctus vehicula. Morbi sodales consequat sem, a tincidunt nisi semper vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      //       score: 1, date: "4-4-4"),
      //   ReviewResult(title: "Title of review 3", user: "Juane Olivan", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at auctor dolor. Mauris varius tincidunt ante eu condimentum. In hac habitasse platea dictumst. Nunc ullamcorper nunc sed porta dignissim. Donec justo arcu, vehicula sit amet odio ac, tincidunt malesuada augue. Nullam sollicitudin mollis hendrerit. Suspendisse libero felis, imperdiet fermentum nunc eget, dictum iaculis tortor. Nam id odio neque. Proin aliquam a diam id aliquet. Maecenas at erat est. Nullam eu enim tortor. Suspendisse vel ex eget ligula luctus vehicula. Morbi sodales consequat sem, a tincidunt nisi semper vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      //       score: 3, date: "4-4-4"),
      //   ReviewResult(title: "Title of review 4", user: "Juane Olivan", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at auctor dolor. Mauris varius tincidunt ante eu condimentum. In hac habitasse platea dictumst. Nunc ullamcorper nunc sed porta dignissim. Donec justo arcu, vehicula sit amet odio ac, tincidunt malesuada augue. Nullam sollicitudin mollis hendrerit. Suspendisse libero felis, imperdiet fermentum nunc eget, dictum iaculis tortor. Nam id odio neque. Proin aliquam a diam id aliquet. Maecenas at erat est. Nullam eu enim tortor. Suspendisse vel ex eget ligula luctus vehicula. Morbi sodales consequat sem, a tincidunt nisi semper vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      //       score: 2, date: "4-4-4"),
      //   ReviewResult(title: "Title of review 5", user: "Juane Olivan", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at auctor dolor. Mauris varius tincidunt ante eu condimentum. In hac habitasse platea dictumst. Nunc ullamcorper nunc sed porta dignissim. Donec justo arcu, vehicula sit amet odio ac, tincidunt malesuada augue. Nullam sollicitudin mollis hendrerit. Suspendisse libero felis, imperdiet fermentum nunc eget, dictum iaculis tortor. Nam id odio neque. Proin aliquam a diam id aliquet. Maecenas at erat est. Nullam eu enim tortor. Suspendisse vel ex eget ligula luctus vehicula. Morbi sodales consequat sem, a tincidunt nisi semper vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      //       score: 4, date: "4-4-4"),
      // ];

      return res;

    } catch (r) {
      rethrow;
    }
  }

  Future<bool>saveRutaCultural({String? name, String? description, required List<EventResult> events}) async{
    try {
      // final jsonList = events.map((e) => json.encode(e)).toList();
      // debugPrint(jsonList.toString());
      final idList = events.map((e) => int.parse(e.id!)).toList();
      debugPrint(idList.toString());
      final Map<String, dynamic> data = {'name': name, 'description': description, 'eventIds': idList};
      debugPrint(jsonEncode(data).toString());
      dynamic response = await _apiServices.getPutApiResponse("${baseUrl}users/${session.data.id}/routes", data);
      debugPrint("on eventRepository line 288: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> postReview(String id, String title, String review, double rating) async {
    try {
      dynamic data = {'title': title, 'review': review, 'stars': rating.toInt()};
      debugPrint("postReview: $data");
      dynamic response = await _apiServices.getPostApiResponse("${baseUrl}users/${session.data.id}/reviews?eventId=$id", data);
      debugPrint("response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

}