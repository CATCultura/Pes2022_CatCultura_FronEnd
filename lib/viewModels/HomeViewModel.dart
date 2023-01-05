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



  void mantaintEventsListToMap(){
    List<Place> aux = [];
    eventsList.data!.forEach((e) {aux.add(Place(event: e, color: Colors.blue)); });
    eventsListMap = ApiResponse.completed(aux);
  }

  List<String> suggestions = [];
  int count = 0;
  Set<int> loadedPages = {};
  bool chargingNextPage = false;
  bool waiting = true;

  void setLoading(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  void refresh(){
    eventsList.status = Status.LOADING;
    loadedPages = {};
    notifyListeners();
  }

  setEventsList(ApiResponse<List<EventResult>> response){
    eventsList = response;
    if(response.status == Status.COMPLETED) mantaintEventsListToMap();
    loadedPages.add(0);
    notifyListeners();
  }

  void setEventTagList(ApiResponse<List<EventResult>> response, String tag) {
    tagEventList[tag] = response;
    tagStatus = Status.COMPLETED;
    notifyListeners();
  }

  void setEvents(ApiResponse<EventResult> response){
    events = response;
    notifyListeners();
  }

  List<String> auxTags = ["arts-visuals", "espectacles", "concerts", "gastronomia", "llibres-i-lletres"];


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
    if (session.data.id != -1 && session.data.tags != null) {
      for (int i = 0; i < session.data.tags!.length; ++i) {
        await _eventsRepo.getEventsByTag(session.data.tags![i]).then((value) {
          setEventTagList(ApiResponse.completed(value), session.data.tags![i]);
        }).onError((error, stackTrace) =>
            setEventsList(ApiResponse.error(error.toString())));
      }
    }
    }


  @override
  void dispose(){
  }
}