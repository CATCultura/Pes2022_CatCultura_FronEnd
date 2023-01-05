import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';


import '../models/Place.dart';
import '../utils/Session.dart';

class OrganizerEventsViewModel with ChangeNotifier{
  final _userRepo = UsersRepository();
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


  List<String> auxTags = ["arts-visuals", "espectacles", "concerts", "gastronomia", "llibres-i-lletres"];


  Future<void> fetchEvents(int id) async {
    //FOR NOW TO MAKE IT THE CUTREST
    await _userRepo.getEventsById(id).then((value) {
      setEventsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));

  }


}