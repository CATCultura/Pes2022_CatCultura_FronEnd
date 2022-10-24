import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/Events.dart';
import 'package:CatCultura/repository/repository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = Repository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();
  ApiResponse<List<EventResult>> assistanceList = ApiResponse.loading();
  ApiResponse<List<EventResult>> favouritesList = ApiResponse.loading();

  int count = 0;


  setEventsList(ApiResponse<List<EventResult>> response){
    print("before eventlist = response (with exit)");
    eventsList = response;
    notifyListeners();
  }

  setEventSelected(ApiResponse<EventResult> response){
    eventSelected = response;
    notifyListeners();
  }

  Future<void> fetchEventsListApi() async {
      await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
      count++;
      debugPrint(count.toString());
  }


  Future<void> selectEventById(String id) async{
    await _eventsRepo.getEventById(id).then((value){
    setEventSelected(ApiResponse.completed(value));
  }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }
  @override
  void dispose() {
  }

  setAssistanceList(ApiResponse<List<EventResult>> response){
    assistanceList = response;
    notifyListeners();
  }

  Future<void> fetchAssistanceById(String id) async{
    await _eventsRepo.getAssistanceByUserId(id).then((value) {
      setAssistanceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setAssistanceList(ApiResponse.error(error.toString())));
  }

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