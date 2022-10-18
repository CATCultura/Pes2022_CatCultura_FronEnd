import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:tryproject2/data/network/networkApiServices.dart';
import 'package:tryproject2/models/Events.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class Repository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  Events _cachedEvents = Events();

  Future<Events> getEvents() async {
    print("entro a repo.getEvents()");
    try {
      print("before response = api.get");
      dynamic response = await _apiServices.getGetApiResponse("http://10.4.41.41:8081/events");
      print("after response = api.get");
      response = Events.fromJson(response);
      _cachedEvents = response;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Events> getEventById(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("http://10.4.41.41:8081/events/$id");
      return response = Events.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


}