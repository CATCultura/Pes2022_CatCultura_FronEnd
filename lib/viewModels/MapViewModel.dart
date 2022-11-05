import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';

import '../models/Place.dart';

class MapViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();
  ApiResponse<List<Place>> items = ApiResponse.completed([
    for (int i = 0; i < 10; i++)
      Place(
        // name: 'Place $i',
        // latLng: LatLng(48.848200 + i * 0.001, 2.319124 + i * 0.001),
        event: EventResult(latitud: 48.848200 + i * 0.001 , longitud: 2.319124 + i * 0.001),
        color: Colors.green,

      ),
    for (int i = 0; i < 10; i++)
      Place(
        // name: 'Restaurant $i',
        // latLng: LatLng(48.858265 - i * 0.001, 2.350107 + i * 0.001),
        event: EventResult(latitud: 48.858265 - i * 0.001 , longitud: 2.350107 + i * 0.001),
        color: Colors.green,

      ),
    for (int i = 0; i < 10; i++)
      Place(
        // name: 'Bar $i',
        // latLng: LatLng(48.858265 + i * 0.01, 2.350107 - i * 0.01),
        event: EventResult(latitud: 48.858265 + i * 0.01 , longitud: 2.350107 - i * 0.01),
          color: Colors.green,
      ),
  ]);

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();

  void refresh(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  setEventsList(ApiResponse<List<EventResult>> response){
    debugPrint("before eventlist = response (with exit)");
    //notifyListeners();
    List<Place> aux = [];
    response.data!.forEach((e) {aux.add(Place(event: e, color: Colors.blue)); });
    items = ApiResponse.completed(aux);
    //eventsList = response;
    debugPrint("------------list of eventList-------------");
    for(EventResult e in eventsList.data!) debugPrint(e.denominacio!);
    // suggestions = [];
    // int suggestLength = 1;// = eventsList.data!.length%10;
    // for (int e = 0; e < suggestLength; ++e) {
    //   suggestions.add(eventsList.data![e].id!);
    // }
    notifyListeners();
  }



  Future<void> fetchEventsListApi() async {
    await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
    debugPrint("MapViewModel");
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


// @override
// void dispose() {
// }

}