import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Place.dart';

class RutaCulturalViewModel with ChangeNotifier {

  //VARIABLES
  final _eventsRepo = EventsRepository();
  Set<Marker> markers = {};
  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<List<Place>> eventsListMap = ApiResponse.loading();

  //STATES
  bool rutaGenerada = false;

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
    eventsListMap.status = Status.LOADING;
    notifyListeners();
    await _eventsRepo.getRutaCultural(args!.longitud,args.latitud,args.radio).then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }
}