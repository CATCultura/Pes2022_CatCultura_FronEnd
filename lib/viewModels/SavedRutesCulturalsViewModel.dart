import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../models/RouteResult.dart';
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
      setRoutesList(ApiResponse.completed(value));
    });
        // .onError((error, stackTrace) =>
        // setRoutesList(ApiResponse.error(error.toString())));
  }
}