import 'dart:convert';

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:CatCultura/data/network/networkApiServices.dart';

import '../models/SessionResult.dart';
// import '../res/app_url.dart'; DE DONDE SALEN LAS URLS PARA LAS LLAMADAS HTTP

class UsersRepository {
  // final baseUrl = "http://40.113.160.200:8081/";
  final baseUrl = "http://10.4.41.41:8081/";
  final NetworkApiServices _apiServices = NetworkApiServices();

  UsersRepository._privateConstructor();

  static final UsersRepository _instance = UsersRepository
      ._privateConstructor();

  factory UsersRepository() {
    return _instance;
  }

  List<UserResult> _cachedUsers = [];

  Future<List<UserResult>> getUsers() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users");

      List<UserResult> res = List.from(
          response.map((e) => UserResult.fromJson(e)).toList());
      _cachedUsers = res;
      //debugPrint(res.toString());
      //debugPrint("nameSurname"+res[0].nameAndSurname!);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserResult>> getUsersWithParameters(int? page, int? size, String? sort) async {
    //events?page=0&size=2&sort=string
    page ??= 0;
    size ??= 20;
    //sort ??= "string";
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users?page=$page&size=$size"); //no va --> &sort=$sort
      List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());
      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserResult>> getUsersWithFilter(String filter) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users?username=$filter");
      debugPrint(filter);
      List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());

      return res;

    } catch (e) {
      rethrow;
    }
  }



  Future<UserResult> getUserById(String id) async {
    UserResult? cached = userInCache(id);
    if (cached.id != null) {
      debugPrint(cached.id.toString()!);
      return cached;
    }
    else {
      try {
        dynamic response = await _apiServices.getGetApiResponse(
            "${baseUrl}users/$id");
        return UserResult.fromJson(response);
      } catch (e) {
        rethrow;
      }
    }
  }


  UserResult userInCache(String id) {
    debugPrint("cached user");
    UserResult result = UserResult();
    for (var e in _cachedUsers) {
      if (e.id == id) result = e;
    }
    return result;
  }

  Future<SessionResult> iniSessio() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}login");
      SessionResult res = SessionResult.fromJson(response);
      debugPrint("Res dedsde userRepo $res");
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<SessionResult> postCreaCompte(UserResult data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          "${baseUrl}users", data.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

/*
  Future<List<UserResult>> getListFriends(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users/$id/friends/session");
      List<UserResult> res = List.from(response.map((e) => UserResult.fromJson(e)).toList());

      return res;//UserResult.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
 */

  Future<List<UserResult>> getFriendsById(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users/$id/friends?status=accepted");
      List<UserResult> res = List.from(
          response.map((e) => UserResult.fromJson(e)).toList());

      return res; //UserResult.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserResult>> getRequestedsById(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users/$id/friends?status=requested");
      List<UserResult> res = List.from(
          response.map((e) => UserResult.fromJson(e)).toList());

      return res; //UserResult.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<List<UserResult>> getReceivedById(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${baseUrl}users/$id/friends?status=received");
      List<UserResult> res = List.from(
          response.map((e) => UserResult.fromJson(e)).toList());

      return res; //UserResult.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<String> addFavouriteByUserId(String id, int otherUserId) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          "${baseUrl}users/$id/friends/$otherUserId", "");
      String res = response;
      return res;
    }
    catch (e) {
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

  Future<String> putEditUser(String password, String id) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          "${baseUrl}users/$id/password", {"new_password":password});
      String res = response;
      return res;
    } catch (e) {
     // rethrow;
      return "Excepció";
    }
  }

  Future<String> postCreaTags(String id, List<String> data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          "${baseUrl}users/$id/tags", data);
      return response;
    }
    catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getUserTags(String id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/$id/tags");
      List<String> tagsAmbits = (response['AMBITS'] as List).map((item) => item as String).toList();
      List<String> tagsAmbitsCateg = (response['ALTRES_CATEGORIES'] as List).map((item) => item as String).toList();
      List<String> tagsAltresCateg = (response['CATEGORIES'] as List).map((item) => item as String).toList();
      List<String> res = [tagsAmbits, tagsAmbitsCateg, tagsAltresCateg].expand((x) => x).toList();
      return res;

    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteUserTags(String id, List<String> data) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          "${baseUrl}users/$id/tags", data);
      return response;
    }
    catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getEventsById(int id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/$id/events");
      List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserResult>>getUsersReports() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${baseUrl}users/reported");
      List<UserResult> res = List.from(response.map((r) => UserResult.fromJson(r)).toList());
      debugPrint("res desde usersRepo getUsersReports(): ${res.toString()}");
      return res;
    } catch (e) {
      rethrow;
    }
  }
}