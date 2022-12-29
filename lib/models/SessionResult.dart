import 'dart:core';

import 'package:flutter/material.dart';

class SessionResult {
  late int     id;
  late String  username;
  String? nameAndSurname = "noNameAndSurname";
  String? email = "noEmail";
  String? creationDate = "noDate";
  late String  role;
  String?  password;
  int?    points = -1;
  late String  hash;
  List<int>? favouritesId = [];
  List<int>? trophiesId = [];
  List<int>? attendanceId = [];
  List<int>? friendsId = [];
  List<int>? upvotedReviewsId = [];
  List<int>? attendedId = [];
  List<int>? reportedReviews = [];
  List<int>? receivedId = [];
  List<int>? requestedId = [];

  SessionResult({
    required this.id,
    required this.username,
    this.nameAndSurname,
    this.email,
    this.creationDate,
    required this.role,
    this.password,
    this.points,
    required this.hash,
    this.favouritesId,
    this.trophiesId,
    this.attendanceId,
    this.friendsId,
    this.upvotedReviewsId,
    this.attendedId,
    this.reportedReviews,
    this.friendsId,
    this.requestedId,
    this.receivedId
  });

  SessionResult.fromJson(Map<String, dynamic> jsonResponse) {
    debugPrint(jsonResponse.toString());
    id = jsonResponse['id'];
    username = jsonResponse['username'];
    nameAndSurname = jsonResponse['nameAndSurname'];
    email = jsonResponse['email'];
    creationDate = jsonResponse['creationDate'];
    role = jsonResponse['role'];
    password = jsonResponse['password'];
    points = jsonResponse['points'];
    hash = jsonResponse['userHash'];
    if(jsonResponse['favouriteEvents'] != null) {
      favouritesId = (jsonResponse['favouriteEvents'] as List).map((item) => item as int).toList();
    }else{
      favouritesId = [];
    }
    if(jsonResponse['trophiesReceived'] != null) {
      trophiesId = (jsonResponse['trophiesReceived'] as List).map((item) => item as int).toList();
    }else{
      trophiesId = [];
    }
    if(jsonResponse['eventsAttendance'] != null) {
      attendanceId = (jsonResponse['eventsAttendance'] as List).map((item) => item as int).toList();
    }else{
      attendanceId = [];
    }
    if(jsonResponse['friendsIds'] != null) {
      friendsId = (jsonResponse['friendsIds'] as List).map((item) => item as int).toList();
    }else {
      friendsId = [];
    }
    if(jsonResponse['upvotedReviewsId'] != null) {
      upvotedReviewsId = (jsonResponse['upvotedReviewsId'] as List).map((item) => item as int).toList();
    }else {
      upvotedReviewsId = [];
    }
    if(jsonResponse['eventsAttended'] != null) {
      attendedId = (jsonResponse['eventsAttended'] as List).map((item) => item as int).toList();
    }else {
      attendedId = [];
    }
    if(jsonResponse['reportedReviewIds'] != null) {
      reportedReviews = (jsonResponse['reportedReviewIds'] as List).map((item) => item as int).toList();
    }else {
      reportedReviews = [];
    }
    if(jsonResponse['requestedIds'] != null) {
      requestedId = (jsonResponse['requestedIds'] as List).map((item) => item as int).toList();
    }else {
      requestedId = [];
    }
    if(jsonResponse['receivedIds'] != null) {
      receivedId = (jsonResponse['receivedIds'] as List).map((item) => item as int).toList();
    }else {
      receivedId = [];
    }
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'id': id, 'username': username}
    ];
    return result;
  }

}