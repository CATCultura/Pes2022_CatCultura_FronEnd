
import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class EventUnicViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();
  ApiResponse<EventResult> event = ApiResponse.loading();

  ApiResponse<String> addFavouriteResult = ApiResponse.loading();
  ApiResponse<String> addAttendanceResult = ApiResponse.loading();

  bool waiting = true;


  setEventSelected(ApiResponse<EventResult> response){
    debugPrint("event selected with status: ${response.status} and title: ${response.data!.denominacio}");
    eventSelected = response;
    notifyListeners();
  }

  setEventResult(ApiResponse<EventResult> response) {
    event = response;
    notifyListeners();
  }

  Future<void> selectEventById(String id) async{
    debugPrint("selecting event by id");
    await _eventsRepo.getEventById(id).then((value){
      setEventSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString())));
  }

  setFavouriteResult(ApiResponse<String> response){
    addFavouriteResult = response;
    notifyListeners();
  }

  setAttendanceResult(ApiResponse<String> response) {
    addAttendanceResult = response;
    notifyListeners();
  }

  Future<void> putFavouriteById(String userId, String? eventId) async{
    if(eventId != null) {
      await _eventsRepo.addFavouriteByUserId(userId, int.parse(eventId)).then((value) {
        setFavouriteResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setFavouriteResult(ApiResponse.error(error.toString())));
    }

  }

  Future<void> deleteFavouriteById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteFavouriteByUserId(userId, int.parse(eventId)).then((value){
        setFavouriteResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setFavouriteResult(ApiResponse.error(error.toString())));
    }
  }

  Future<void> putAttendanceById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.addAttendanceByUserId(userId, int.parse(eventId)).then((value){
        setAttendanceResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setAttendanceResult(ApiResponse.error(error.toString())));
    }
  }

  Future<void> deleteAttendanceById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteAttendanceByUserId(userId, int.parse(eventId)).then((value){
        setAttendanceResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setAttendanceResult(ApiResponse.error(error.toString())));
    }
  }
  // @override
  // void dispose() {
  // }

  /** Future<void> deleteEventById(String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteEventId(eventId).then((value){
        setEventSelected(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setEventSelected(ApiResponse.error(error.toString())));
    }
    waiting = false;
  } **/

  Future<void> putEventById(String? id, String? d) async {
    EventResult e = EventResult();
    e.denominacio = d;
    await _eventsRepo.addEventById(id, e);/**.then((value) {
      setEventSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString()))); **/
    waiting = false;
  }
}