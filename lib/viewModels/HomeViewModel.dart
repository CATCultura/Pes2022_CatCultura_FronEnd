import 'package:flutter/cupertino.dart';
import 'package:tryproject2/data/response/apiResponse.dart';
import 'package:tryproject2/models/Events.dart';
import 'package:tryproject2/repository/repository.dart';

class HomeViewModel with ChangeNotifier{
  final _eventsRepo = Repository();

  ApiResponse<Events> eventsList = ApiResponse.loading();

  setEventsList(ApiResponse<Events> response){
    eventsList = response;
    // ignore: unnecessary_null_comparison
    //debugPrint("in HomeViewModel we have this events: ${response.data! ==  null ? "nothing" : response.data!.results![0].id!.isEmpty ? "is empty" : response.data!.results![0].id!.toString()}");
    notifyListeners();
  }

  Future<void> fetchEventsListApi() async {
    await _eventsRepo.getEvents().then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }

}