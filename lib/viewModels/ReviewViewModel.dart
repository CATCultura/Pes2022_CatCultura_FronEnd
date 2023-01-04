import 'dart:io';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/ReviewResult.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../utils/Session.dart';

class ReviewViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final session = Session();
  late ReviewResult review;

  late bool isMine;
  late bool isUpvoted;
  late bool isReported;

  void setReview(ReviewResult review) {
    this.review = review;
    if(session.data.id == review.userId) isMine = true;
    else isMine = false;
    if(session.data.reportedReviews!.contains(review.reviewId!)) isReported = true;
    else isReported = false;
    if(session.data.upvotedReviews!.contains(review.reviewId!)) isUpvoted = true;
    else isUpvoted = false;
    notifyListeners();
  }

  Future<void> reportReview() async {
    if(review.userId != null && review.reviewId != null) {
      await _eventsRepo.reportReview(review.userId!, review.reviewId!).then((value) {
          isReported = true;
          session.data.reportedReviews = value;
          notifyListeners();
      });
    }
  }

  void deleteReview() {
    if(review.userId != null && review.reviewId != null) {
      _eventsRepo.deleteReview(review.userId!, review.reviewId!).then((value) {
          isMine = false;
          notifyListeners();
      });
    }
  }

  Future<void> downvote() async {
    isUpvoted = false;
    notifyListeners();
    if(review.userId != null && review.reviewId != null) {
      await _eventsRepo.downvoteReview(review.userId!, review.reviewId!).then((value) {
        if(value.contains(review.reviewId!)) {
          isUpvoted = false;
          session.data.upvotedReviews = value;
          notifyListeners();
        }
      });
    }
  }

  Future<void> upvote() async {
    isUpvoted = true;
    notifyListeners();
    if(review.userId != null && review.reviewId != null) {
      await _eventsRepo.upvoteReview(review.userId!, review.reviewId!).then((value) {
        isUpvoted = true;
        session.data.upvotedReviews = value;
        notifyListeners();
      });
    }
  }

}