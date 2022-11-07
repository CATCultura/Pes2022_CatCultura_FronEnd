import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class EventUnicViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();


  setEventSelected(ApiResponse<EventResult> response){
    debugPrint("event selected with status: ${response.status} and title: ${response.data!.denominacio}");
    eventSelected = response;
    notifyListeners();
  }

  Future<void> selectEventById(String id) async{
    debugPrint("selecting event by id");
    await _eventsRepo.getEventById(id).then((value){
      setEventSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString())));
  }

  // @override
  // void dispose() {
  // }
}