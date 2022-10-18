import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:tryproject2/data/network/networkApiServices.dart';
import 'package:tryproject2/models/Events.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class Repository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<Events> getEvents() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("http://10.4.41.41:8081/events/8");
      return response = Events.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}