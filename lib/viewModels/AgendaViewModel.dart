import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class AgendaViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<List<EventResult>> attendanceList = ApiResponse.loading();

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
}