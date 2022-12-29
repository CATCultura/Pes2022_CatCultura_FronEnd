import 'package:flutter/material.dart';

import '../repository/EventsRepository.dart';

class ReviewUnicaViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();

  Future<void> sendReview(String id, String? title, String? review, double rating) async {
    title ??= "NO_TITLE";
    review ??= "NO_TEXT";
    await _eventsRepo.postReview(id, title, review, rating).then((value){
      debugPrint(value.toString());
    }).onError((error, stackTrace) => null);
  }

}