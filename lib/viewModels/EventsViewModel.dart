import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/Events.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();

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

}