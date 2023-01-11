
import 'package:flutter/cupertino.dart';

import '../data/response/apiResponse.dart';
import '../models/EventResult.dart';
import '../repository/EventsRepository.dart';

class CreateEventsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();

  bool waiting = true;

  void setLoading(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  void refresh(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  setEventsList(ApiResponse<List<EventResult>> response) {
    eventsList = response;
    notifyListeners();
  }

  Future<void> crearEvent(EventResult e) async {
    await _eventsRepo.postCreaEvent(e).then((value) {
      //setEventsList(ApiResponse.completed([value]));
    }); /**.onError((error, stackTrace) =>
        setEvents(ApiResponse.error(error.toString()))); **/
    waiting = false;
    notifyListeners();
  }

  @override
  dispose() {}
}