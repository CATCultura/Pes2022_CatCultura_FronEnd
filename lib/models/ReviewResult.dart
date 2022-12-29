import 'dart:core';

import 'package:flutter/material.dart';

class ReviewResult {
  String? title = "noTitle";
  String? review = "noText";
  int? rating = 0;
  String? author = "noUser";
  int? userId = -1;
  int? reviewId = -1;
  String? date = "noDate";
  int? upvotes = 0;

  ReviewResult({
    this.title,
    this.review,
    this.rating,
    this.author,
    this.userId,
    this.reviewId,
    this.date,
    this.upvotes,
  });

  ReviewResult.fromJson(Map<String, dynamic> jsonResponse) {
    title = jsonResponse['title'];
    review = jsonResponse['review'];
    rating = jsonResponse['stars'];
    author = jsonResponse['authorUsername'];
    reviewId = jsonResponse['id'];
    userId = jsonResponse['authorId'];
    date = jsonResponse['date'];
    upvotes = jsonResponse['upvotes'];
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'title': title, 'text': review, 'score': rating, 'user': author,
        'date': date}
    ];
    return result;
  }

}