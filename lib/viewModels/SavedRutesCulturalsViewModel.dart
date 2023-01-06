import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../models/RouteResult.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/Session.dart';

class SavedRutesCulturalsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<List<RouteResult>> routeList = ApiResponse.loading();
  final session = Session();

  setRoutesList(ApiResponse<List<RouteResult>> response){
    routeList = response;
    notifyListeners();
  }

  Future<void> getSavedRoutes() async{
    await _eventsRepo.getSavedRoutes(session.data.id.toString()).then((value) {
      for (var e in value){debugPrint("rutas guardadas!!!"+e.id!);}
      setRoutesList(ApiResponse.completed(value));
    });
        // .onError((error, stackTrace) =>
        // setRoutesList(ApiResponse.error(error.toString())));
  }

  Future<void> deleteRoute(String routeId) async{
    if(session.data.id != -1) {
      await _eventsRepo.deleteRouteById(routeId, session.data.id.toString()).then((value) {
        getSavedRoutes();
      }).onError((error, stackTrace) {
        debugPrintStack(stackTrace: stackTrace, label: error.toString());
      }
      );
    }
  }
  shareEvent(String s) async{
    Share.share('Mira la ruta culural que m\'ha creat CatCultura !!!\nhttp://catcultura.com/rutaCultural?code='+s);
  }
}