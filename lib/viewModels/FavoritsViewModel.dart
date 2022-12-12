import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../utils/Session.dart';

class FavoritsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final sessio = Session();
  ApiResponse<List<EventResult>> favouritesList = ApiResponse.loading();

  String usernameSessio() {
    if(sessio.get("username") == null) return "13658";
    return sessio.get("username");
  }

  String passwordSessio() {
    if(sessio.get("password") == null) return "13658";
    return sessio.get("password");
  }

  setFavouritesList(ApiResponse<List<EventResult>> response){
    favouritesList = response;
    sessio.set("favorits", favouritesList);
    notifyListeners();
  }

  Future<void> fetchFavouritesById(String id) async{
    await _eventsRepo.getFavouritesByUserId(id).then((value) {
      setFavouritesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setFavouritesList(ApiResponse.error(error.toString())));
  }
}