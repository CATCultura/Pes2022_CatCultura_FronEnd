import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import '../models/Place.dart';

class RutaCulturalViewModel with ChangeNotifier {
  bool rutaGenerada = false;
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<List<Place>> eventsListMap = ApiResponse.loading();

  void mantaintEventsListToMap() {
    List<Place> aux = [];
    eventsList.data!.forEach((e) {aux.add(Place(event: e, color: Colors.blue));});
    eventsListMap = ApiResponse.completed(aux);
  }

  setEventsList(ApiResponse<List<EventResult>> response){
    eventsList = response;
    mantaintEventsListToMap();
    notifyListeners();
  }

  Future<void> generateRutaCultural(RutaCulturalArgs? args) async {
    await _eventsRepo.getRutaCultural(args!.longitud,args.latitud,args.radio).then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }
}