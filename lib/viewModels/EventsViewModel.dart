import 'package:flutter/cupertino.dart';
import 'package:tryproject2/data/response/apiResponse.dart';
import 'package:tryproject2/models/Events.dart';
import 'package:tryproject2/repository/repository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = Repository();

  ApiResponse<Events> eventsList = ApiResponse.loading();


  setEventsList(ApiResponse<Events> response){
    eventsList = response;
    notifyListeners();
  }

  Future<void> fetchEventsListApi() async {
    if(eventsList.status == Status.COMPLETED){

    } else {
      await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
    }
  }

}