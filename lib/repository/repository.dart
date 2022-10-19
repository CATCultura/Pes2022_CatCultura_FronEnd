import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:CatCultura/data/network/networkApiServices.dart';
import 'package:CatCultura/models/Events.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class Repository {
  final baseUrl = "http://10.4.41.41:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();
  List<EventResult> _cachedEvents = [];

  Future<List<EventResult>> getEvents() async {
    print("entro a repo.getEvents()");
    try {
      print("before response = api.get");
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events");
      print("after response = api.get");
      //response = Events.fromJson(response);
      _cachedEvents = response;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<EventResult> getEventById(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}events/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }


}