import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/Events.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();
  ApiResponse<List<EventResult>> attendanceList = ApiResponse.loading();
  ApiResponse<List<EventResult>> favouritesList = ApiResponse.loading();

  int count = 0;


  setEventsList(ApiResponse<List<EventResult>> response){
    print("before eventlist = response (with exit)");
    eventsList = response;
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


  // @override
  // void dispose() {
  // }
  @override
  void dispose() {
  }

  setAttendanceList(ApiResponse<List<EventResult>> response){
    attendanceList = response;
    notifyListeners();
  }

  Future<void> fetchAttendanceById(String id) async{
    await _eventsRepo.getAttendanceByUserId(id).then((value) {
      setAttendanceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setAttendanceList(ApiResponse.error(error.toString())));
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

  Future<void> putFavouriteById(String userId, eventId) async{
    await _eventsRepo.addFavouriteByUserId(userId, eventId).onError((error, stackTrace) =>
    "error");
  }

}