import 'dart:core';

import 'package:flutter/material.dart';

class ReviewResult {
  String? title = "noTitle";
  String? text = "noText";
  int? score = 0;
  String? user = "noUser";
  String? date = "noDate";

  ReviewResult({
    this.title,
    this.text,
    this.score,
    this.user,
    this.date,
  });

  ReviewResult.fromJson(Map<String, dynamic> jsonResponse) {
    title = jsonResponse['title'];
    text = jsonResponse['text'];
    score = jsonResponse['score'];
    user = jsonResponse['user'];
    date = jsonResponse['date'];
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'title': title, 'text': text, 'score': score, 'user': user,
        'date': date}
    ];
    return result;
  }

}