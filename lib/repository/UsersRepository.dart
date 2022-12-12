import 'dart:convert';

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:CatCultura/data/network/networkApiServices.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class UsersRepository {
  final baseUrl = "http://10.4.41.41:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();

  UsersRepository._privateConstructor();

  static final UsersRepository _instance = UsersRepository._privateConstructor();

  factory UsersRepository() {
    return _instance;
  }

  List<UserResult> _cachedUsers = [];

  Future<List<UserResult>> getUsers() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users");

      List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());
      _cachedUsers = res;
      debugPrint(res.toString());
      debugPrint("nameSurname"+res[0].nameAndSurname!);
      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<UserResult> getUserById(String id) async {
    UserResult? cached = userInCache(id);
    if(cached.id!= null) {
      debugPrint(cached.id.toString()!);
      return cached;
    }
    else{
      try {
        dynamic response = await _apiServices.getGetApiResponse(
            "${baseUrl}users/$id");
        return UserResult.fromJson(response);
      } catch (e) {
        rethrow;
      }
    }
  }


  UserResult userInCache(String id){
    debugPrint("cached user");
    UserResult result = UserResult();
    for (var e in _cachedUsers) {
      if(e.id == id) result = e;
    }
    return result;
  }

  Future<UserResult> iniSessio() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}auth");
      UserResult res = UserResult.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserResult> postCreaCompte(UserResult data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse("${baseUrl}users", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UserResult>> getRequestedsById(String id) async {
   // List<UserResult?> cached = userInCache(id);
   // if(cached.id!= null) {
     // debugPrint(cached.id.toString()!);
      //return cached;
    //}
    //else{
      try {
        dynamic response = await _apiServices.getGetApiResponse(
            "${baseUrl}users/$id/friends?status=requested");
        List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());

        return res;//UserResult.fromJson(response);
      } catch (e) {
        rethrow;
      }
  }


  Future<List<UserResult>> getReceivedById(String id) async {

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users/$id/friends?status=received");
      List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());

      return res;//UserResult.fromJson(response);
    } catch (e) {
      rethrow;
    }

  }



  Future<String> addFavouriteByUserId(String id, int otherUserId) async {
    try{
      dynamic response = await _apiServices.getPutApiResponse("${baseUrl}users/$id/friends/$otherUserId", "" );
      String res = response;
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> deleteFavouriteByUserId(String id, int otherUserId) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          "${baseUrl}users/$id/friends/$otherUserId", "");
      String res = response;
      return res;
    }
    catch (e) {
      rethrow;
    }
  }
}