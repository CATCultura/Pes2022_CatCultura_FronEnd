import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class EventsViewModel with ChangeNotifier{
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  List<String> suggestions = [];
  int count = 0;

 void refresh(){
   eventsList.status = Status.LOADING;
   notifyListeners();
 }

  setEventsList(ApiResponse<List<EventResult>> response){
    print("before eventlist = response (with exit)");
    eventsList = response;
    for (int e = 0; e < 4; ++e) {
      suggestions.add(eventsList.data![e].id!);
    }
    notifyListeners();
  }



  Future<void> fetchEventsListApi() async {
      await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
      count++;
      debugPrint("EvViewModel. times accesed fetchEvents: $count");
  }


  // @override
  // void dispose() {
  // }

}