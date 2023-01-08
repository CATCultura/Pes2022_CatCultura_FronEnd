
import 'package:CatCultura/models/UserResult.dart';
import 'package:flutter/material.dart';

import '../data/response/apiResponse.dart';
import '../models/ReviewResult.dart';
import '../repository/EventsRepository.dart';
import '../repository/UsersRepository.dart';

class BlocksViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final _usersRepo = UsersRepository();

  ApiResponse<List<ReviewResult>> reviewsList = ApiResponse.loading();
  ApiResponse<List<UserResult>> usersList = ApiResponse.loading();

  Future<void> fetchReviewsReports() async {
    await _eventsRepo.getReviewsReports().then((value) {
      reviewsList = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      reviewsList = ApiResponse.error(error.toString());
      notifyListeners();
    });
  }

  Future<void> fetchUsersReports() async {
    await _usersRepo.getUsersReports().then((value) {
      usersList = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      usersList = ApiResponse.error(error.toString());
      notifyListeners();
    });
  }

  Future<void> blockReview(int reviewId) async {
    await _eventsRepo.blockReview(reviewId.toString()).then((_) {
      fetchReviewsReports();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      notifyListeners();
    });
  }

  Future<void> unblockReview(int reviewId) async {
    await _eventsRepo.unblockReview(reviewId.toString()).then((_) {
      fetchReviewsReports();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      notifyListeners();
    });
  }

  Future<void> blockUser(String userId) async {
    await _usersRepo.blockUser(userId).then((_) {
      fetchUsersReports();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      notifyListeners();
    });
  }

  Future<void> unblockUser(String userId) async {
    await _usersRepo.unblockUser(userId).then((_) {
      fetchUsersReports();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      notifyListeners();
    });
  }

}