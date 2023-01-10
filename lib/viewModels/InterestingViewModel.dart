
import 'package:flutter/material.dart';

import '../models/EventResult.dart';
import '../repository/EventsRepository.dart';
import '../utils/Session.dart';

class InterestingViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final session = Session();

  bool aux = false;
  void updateSession(dynamic response) {
    session.data.favouritesId = List<int>.from(response.map((e) => int.parse(e.id!)).toList());
    aux = !aux;
    notifyListeners();
  }

  Future<void> putFavouriteById(String? eventId) async {
    if (eventId != null) {
      await _eventsRepo.addFavouriteByUserId(
          session.data.id.toString(), int.parse(eventId)).then((value) {
        updateSession(value);
        // favourites[eventId] = true;
        notifyListeners();
      }).onError((error, stackTrace) =>
      null);
    }
  }

  Future<void> deleteFavouriteById(String? eventId) async {
    if (eventId != null) {
      await _eventsRepo.deleteFavouriteByUserId(
          session.data.id.toString(), int.parse(eventId)).then((value) {
        updateSession(value);
        // favourites[eventId] = false;
        notifyListeners();
      }).onError((error, stackTrace) => null);
    }
  }

  bool isFavourite(String eventId) {
    return Session()
        .data
        .favouritesId!
        .contains(int.parse(eventId));

  }

  @override
  void dispose() {
    // TODO: implement dispose

  }

}