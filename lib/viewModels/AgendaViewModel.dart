import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../utils/Session.dart';

class AgendaViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<List<EventResult>> attendanceList = ApiResponse.loading();

  final session = Session();

  String usernameSessio() {
    if(session.get("username") == null) return session.data.id.toString();
    return session.get("username");
  }

  String passwordSessio() {
    if(session.get("password") == null) return session.data.id.toString();
    return session.get("password");
  }

  setAttendanceList(ApiResponse<List<EventResult>> response){
    attendanceList = response;
    notifyListeners();
  }

  Future<void> fetchAttendanceFromSession() async{
    await _eventsRepo.getAttendanceByUserId(session.data.id.toString()).then((value) {
      setAttendanceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setAttendanceList(ApiResponse.error(error.toString())));
  }
}