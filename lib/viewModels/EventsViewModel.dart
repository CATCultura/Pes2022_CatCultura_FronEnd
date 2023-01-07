import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Place.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<EventResult> events = ApiResponse.loading();
  ApiResponse<List<Place>> eventsListMap = ApiResponse.loading();//= ApiResponse.completed([
  ApiResponse<List<EventResult>> eventsSimilars = ApiResponse.loading();
  ApiResponse<List<EventResult>> eventsNoSimilars = ApiResponse.loading();

  late CameraPosition iniCameraPosition = const CameraPosition(target: LatLng(41.37, 2.16), zoom: 12.0);
  late Position realPosition;
  late bool located = false;


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
  bool userUsedFilter = false;

  void setLoading(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

 void refresh(){
   eventsList.status = Status.LOADING;
   eventsSimilars.status = Status.LOADING;
   eventsNoSimilars.status = Status.LOADING;
   loadedPages = {};
   userUsedFilter = false;
   located = false;
   notifyListeners();
 }

  setEventsList(ApiResponse<List<EventResult>> response){
    eventsList = response;
    if(response.status == Status.COMPLETED) mantaintEventsListToMap();
    loadedPages.add(0);
    notifyListeners();
  }

  setEventsSimilars(ApiResponse<List<EventResult>> response){
    eventsSimilars = response;
    notifyListeners();
  }
  setEventsNoSimilars(ApiResponse<List<EventResult>> response){
    eventsNoSimilars = response;
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
    await _eventsRepo.getEventsWithFilter2(filter).then((value) {
      debugPrint("---------------LISTS WITH FILTER---------------------");
      value[0].forEach((element) {debugPrint(element.denominacio!);});
      debugPrint("-------------------------------------");

      value[1].forEach((element) {debugPrint(element.denominacio!);});

      setEventsList(ApiResponse.completed(value[0]+value[1]));
      setEventsSimilars(ApiResponse.completed(value[0]));
      setEventsNoSimilars(ApiResponse.completed(value[1]));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
    debugPrint("EvViewModel, accesed from filter redraw");
  }

  // Future<void> fetchEventsNextPage() async {
  //   debugPrint("--charging next page: ${lastPage()+1}");
  //  chargingNextPage = true;
  //  notifyListeners();
  //   await _eventsRepo.getEventsWithParameters(lastPage()+1,null, null).then((value) {
  //     addToEventsList(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) =>
  //       setEventsList(ApiResponse.error(error.toString())));
  //
  // }

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

  // @override
  // void dispose() {
  // }

  Future<void> crearEvent(EventResult e) async {
    await _eventsRepo.postCreaEvent(e).then((value) {
      setEventsList(ApiResponse.completed(value));
    }); /**.onError((error, stackTrace) =>
        setEvents(ApiResponse.error(error.toString()))); **/
    waiting = false;
    notifyListeners();
    }

  Future<void> getEventsNearMe() async {
    await _eventsRepo.getEventsNearMe(realPosition.longitude, realPosition.latitude).then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
        debugPrintStack(label: "Error en getEventsNearMe", stackTrace: stackTrace);
        setEventsList(ApiResponse.error(error.toString()));
    });
  }
}