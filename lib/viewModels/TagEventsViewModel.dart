import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';


import '../models/Place.dart';
import '../utils/Session.dart';

class TagEventsViewModel with ChangeNotifier{
  final _eventRepo = EventsRepository();
  final session = Session();

  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();

  void setLoading(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  void refresh(){
    eventsList.status = Status.LOADING;
    notifyListeners();
  }

  setEventsList(ApiResponse<List<EventResult>> response){
    eventsList = response;
    notifyListeners();
  }


  Future<void> fetchEvents(String tag) async {
    await _eventRepo.getEventsByTag(tag).then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));

  }


}