import 'package:flutter/cupertino.dart';
import 'package:tryproject2/data/response/apiResponse.dart';
import 'package:tryproject2/models/Events.dart';
import 'package:tryproject2/repository/repository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = Repository();

  ApiResponse<Events> eventsList = ApiResponse.loading();
  ApiResponse<Events> eventSelected = ApiResponse.loading();


  setEventsList(ApiResponse<Events> response){
    print("before eventlist = response (with exit)");
    eventsList = response;
    notifyListeners();
  }

  setEventSelected(ApiResponse<Events> response){
    eventSelected = response;
    notifyListeners();
  }

  Future<void> fetchEventsListApi() async {
      await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));

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

}