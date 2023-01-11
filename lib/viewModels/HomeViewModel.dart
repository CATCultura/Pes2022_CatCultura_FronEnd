import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';


import '../models/Place.dart';
import '../utils/Session.dart';

class HomeViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();
  final session = Session();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  Map<String, ApiResponse<List<EventResult>>> tagEventList = {};
  Status tagStatus = Status.LOADING;
  ApiResponse<EventResult> events = ApiResponse.loading();
  ApiResponse<List<Place>> eventsListMap = ApiResponse.loading();//= ApiResponse.completed([ç


  void updateSession(dynamic response) {
    session.data.favouritesId = response.map((e) => int.parse(e.id!)).toList();
  }

  Future<void> putFavouriteById(String userId, String? eventId) async{
    if(eventId != null) {
      await _eventsRepo.addFavouriteByUserId(session.data.id.toString(), int.parse(eventId)).then((value) {
        updateSession(value);
      }).onError((error, stackTrace) =>
          null);
    }
  }

  Future<void> deleteFavouriteById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteFavouriteByUserId(session.data.id.toString(), int.parse(eventId)).then((value){
        updateSession(value);
      }).onError((error, stackTrace) => null);
    }
  }



  setEventsList(ApiResponse<List<EventResult>> response){
    eventsList = response;
    notifyListeners();
  }

  setEventTagList(ApiResponse<List<EventResult>> response, String tag) {
    tagEventList[tag] = response;
    tagStatus = Status.COMPLETED;
    notifyListeners();
  }

  void setEvents(ApiResponse<EventResult> response){
    events = response;
    notifyListeners();
  }

  Future<void> fetchEventsByTag() async {
    if (session.data.id != -1 && session.data.tags != null) {
      for (int i = 0; i < session.data.tags!.length; ++i) {
        await _eventsRepo.getEventsByTag(session.data.tags![i]).then((value) {
          setEventTagList(ApiResponse.completed(value), session.data.tags![i]);
        }).onError((error, stackTrace) =>
            setEventTagList(ApiResponse.error(error.toString()),session.data.tags![i]));
      }
    }
  }


  Future<void> fetchEvents() async {
    //FOR NOW TO MAKE IT THE CUTREST
    if (session.data.tags != null) {
      for (String a in session.data.tags!) {
        tagEventList[a] = ApiResponse.loading();
      }
    }

    await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
  }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
    }


  @override
  void dispose(){
  }

  Future<void> fetchEventsByTagListPosition(int i) async {
    await _eventsRepo.getEventsByTag(session.data.tags![i]).then((value) {
      setEventTagList(ApiResponse.completed(value), session.data.tags![i]);
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }
}