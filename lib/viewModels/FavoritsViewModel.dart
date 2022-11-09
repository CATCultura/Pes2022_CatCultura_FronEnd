import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/Events.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class FavoritsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<List<EventResult>> favouritesList = ApiResponse.loading();

  setFavouritesList(ApiResponse<List<EventResult>> response){
    favouritesList = response;
    notifyListeners();
  }

  Future<void> fetchFavouritesById(String id) async{
    await _eventsRepo.getFavouritesByUserId(id).then((value) {
      setFavouritesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setFavouritesList(ApiResponse.error(error.toString())));
  }
}