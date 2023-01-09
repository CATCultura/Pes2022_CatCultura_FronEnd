import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../utils/Session.dart';

class FavoritsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final session = Session();
  ApiResponse<List<EventResult>> favouritesList = ApiResponse.loading();

  String usernameSessio() {
    if(session.get("username") == null) return "2";
    return session.get("username");
  }

  String passwordSessio() {
    if(session.get("password") == null) return "2";
    return session.get("password");
  }

  setFavouritesList(ApiResponse<List<EventResult>> response){
    favouritesList = response;
    session.set("favorits", favouritesList.data as List<EventResult>);
    notifyListeners();
  }

  Future<void> deleteFavouriteById(String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteFavouriteByUserId(session.data.id.toString(), int.parse(eventId)).then((value){
        session.data.favouritesId = value.map((e) => int.parse(e.id!)).toList();
        setFavouritesList(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setFavouritesList(ApiResponse.error(error.toString())));
    }
  }

  Future<void> fetchFavouritesFromSession() async{
    await _eventsRepo.getFavouritesByUserId(session.data.id.toString()).then((value) {
      setFavouritesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setFavouritesList(ApiResponse.error(error.toString())));
  }
}