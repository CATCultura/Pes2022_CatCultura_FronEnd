import 'dart:convert';

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/TrophyResult.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:CatCultura/data/network/networkApiServices.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class TrophyRepository {
  final baseUrl = "http://40.113.160.200:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();

  TrophyRepository._privateConstructor();

  static final TrophyRepository _instance = TrophyRepository._privateConstructor();

  factory TrophyRepository() {
    return _instance;
  }

  List<TrophyResult> _cachedTrophy = [];

  Future<List<TrophyResult>> getTrophy() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}trophies");

      List<TrophyResult> res = List.from(response.map((e) => TrophyResult.fromJson(e)).toList());
      _cachedTrophy = res;
      debugPrint(res.toString());
      debugPrint("name"+res[0].name!);
      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<List<TrophyResult>> getMyTrophies(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/$id/trophies");

      List<TrophyResult> res = List.from(response.map((e) => TrophyResult.fromJson(e)).toList());
      _cachedTrophy = res;
      debugPrint(res.toString());
      debugPrint("name"+res[0].name!);
      return res;

    } catch (e) {
      rethrow;
    }
  }

/* //No existe
  Future<TrophyResult> getTrophyById(String id) async {
    TrophyResult? cached = TrophyInCache(id);
    if(cached.id!= null) {
      debugPrint(cached.id.toString()!);
      return cached;
    }
    else{
      try {
        dynamic response = await _apiServices.getGetApiResponse(
            "${baseUrl}trophies/$id");
        return TrophyResult.fromJson(response);
      } catch (e) {
        rethrow;
      }
    }
  }
*/

  TrophyResult TrophyInCache(String id){
    debugPrint("cached Trophy");
    TrophyResult result = TrophyResult();
    for (var e in _cachedTrophy) {
      if(e.id == id) result = e;
    }
    return result;
  }




}