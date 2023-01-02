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
    notifyListeners();
  }

  void setEvents(ApiResponse<EventResult> response){
    events = response;
    notifyListeners();
  }

  void addToEventsList(ApiResponse<List<EventResult>> apiResponse) {
    if(apiResponse.status == Status.COMPLETED && eventsList.status == Status.COMPLETED){
      chargingNextPage = false;
      List<EventResult> aux = eventsList.data!;
      aux.addAll(apiResponse.data!);
      eventsList = ApiResponse.completed(aux);
      mantaintEventsListToMap();
      //loadedPages.add(lastPage()+1);
    }
    notifyListeners();
  }


  Future<void> fetchEvents() async {
    if (session.data.id == -1) {
      await _eventsRepo.getEvents().then((value) {
        setEventsList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setEventsList(ApiResponse.error(error.toString())));
    }
    else {
      if (session.data.tags != null) {
        for (int i = 0; i < max(3,session.data.tags!.length); ++i) {
          await _eventsRepo.getEventsByTag(session.data.tags![i]).then((value) {
            setEventTagList(ApiResponse.completed(value), session.data.tags![i]);
          }).onError((error, stackTrace) =>
              setEventsList(ApiResponse.error(error.toString())));
        }
      }
    }
    if(loadedPages.isEmpty) {
      loadedPages.add(0);
      await _eventsRepo.getEvents().then((value) {
        setEventsList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setEventsList(ApiResponse.error(error.toString())));
      count++;
      debugPrint("EvViewModel. times accesed fetchEvents: $count");
    }
    else{
      debugPrint("--all list : ${loadedPages}");
      debugPrint("--charging next page: ${lastPage()}");
      await _eventsRepo.getEventsWithParameters(lastPage(),null, null).then((value) {
        addToEventsList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setEventsList(ApiResponse.error(error.toString())));
    }
  }

  Future<void> redrawWithFilter(String filter) async{
    await _eventsRepo.getEventsWithFilter(filter).then((value) {
      debugPrint("---------------LIST WITH FILTER---------------------");
      for(EventResult e in value) debugPrint("  -${e.denominacio!}");
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
    debugPrint("EvViewModel, accesed from filter redraw");
  }

  int lastPage(){
    int result = 0;
    final List<int> list = loadedPages.toList();
    if(list.isNotEmpty) result = list.reduce(max);
    return result;
  }

  void addNewPage() {
    loadedPages.add(lastPage()+1);
    chargingNextPage = true;
    notifyListeners();
    fetchEvents();
  }

  Future<void> crearEvent(EventResult e) async {
    await _eventsRepo.postCreaEvent(e).then((value) {
      setEvents(ApiResponse.completed(value));
    }); /**.onError((error, stackTrace) =>
        setEvents(ApiResponse.error(error.toString()))); **/
    waiting = false;
    notifyListeners();
  }


}