

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/response/apiResponse.dart';
import '../models/EventResult.dart';
import '../models/StationResult.dart';
import '../repository/stationRepository.dart';

class SingleEventMapViewModel with ChangeNotifier {
  final _stationRepo = StationRepository();
  late EventResult event;
  late BitmapDescriptor markerbitmap;
  ApiResponse<List<StationResult>> eventSelected = ApiResponse.loading();

  void ini(EventResult event) {
    this.event = event;
  }

  var markers = <Marker>{};

  Future<void> getStation(double latitud, double longitud, int radius) async {
      markers.add(
        Marker(
          markerId: const MarkerId("marker"),
          position: LatLng(event.latitud!, event.longitud!),
        ),
      );
      markerbitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "resources/img/electricity.png",
      );
      await _stationRepo.getStations(100, latitud, longitud).then((value){
        eventSelected = ApiResponse.completed(value);
        value.forEach((element) {
          markers.add(
            Marker(
              icon: markerbitmap,
              markerId: MarkerId(element.id.toString()),
              position: LatLng(element.latitud!, element.longitud!),
              infoWindow: InfoWindow(
                title: element.nPlaces.toString(),
                snippet: element.direccion,
              ),
            ),
          );
        });
        notifyListeners();
      }).catchError((e, s){
        debugPrintStack(stackTrace: s, label: e.toString());
        eventSelected = ApiResponse.error(e.toString());
        notifyListeners();

    });
  }


}