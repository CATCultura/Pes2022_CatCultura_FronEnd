import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:tryproject2/data/network/networkApiServices.dart';
import 'package:tryproject2/models/Events.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class Repository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<Events> getEvents() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(""); //"xx" v AppUrl.moviesPopularMovie
      debugPrint("getetEvents");
      debugPrint("Response in repositoryEvents before Events.fromJson:\n$response");
      return response = Events.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}