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
  List<int>? upvotedReviews = [];
  List<int>? attendedId = [];
  List<int>? reportedReviews = [];

  List<String>? tags = [];


  List<int>? friendsId = [];
  List<int>? receivedRequestsIds = [];
  List<int>? sentRequestsIds = [];
  List<int>? reportedUserIds = [];


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
    this.upvotedReviews,
    this.attendedId,
    this.reportedReviews,
    this.friendsId,
    this.sentRequestsIds,
    this.receivedRequestsIds,
    this.reportedUserIds
  });

  SessionResult.fromJson(Map<String, dynamic> jsonResponse) {
    debugPrint(jsonResponse.toString());
    id = jsonResponse['id'];
    if (jsonResponse['username'] != null) {
      username = jsonResponse['username'];
    } else {
      username = "No username";
    }
    if (jsonResponse['nameAndSurname'] != null){
      nameAndSurname = jsonResponse['nameAndSurname'];
    } else {
      nameAndSurname = "No name";
    }
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
    if(jsonResponse['friendIds'] != null) {
      friendsId = (jsonResponse['friendIds'] as List).map((item) => item as int).toList();
    }else {
      friendsId = [];
    }
    if(jsonResponse['upvotedReviewsId'] != null) {
      upvotedReviews = (jsonResponse['upvotedReviewsId'] as List).map((item) => item as int).toList();
    }else {
      upvotedReviews = [];
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

    if (jsonResponse['tags'] != null) {
      tags = (jsonResponse['tags'] as List).map((item) => item as String).toList();
    } else {
      tags = [];
    }

    if(jsonResponse['reportedUserIds'] != null) {
      reportedUserIds = (jsonResponse['reportedUserIds'] as List).map((item) => item as int).toList();
    }else {
      reportedUserIds = [];
    }

    if(jsonResponse['sentRequestsIds'] != null) {
      sentRequestsIds = (jsonResponse['sentRequestsIds'] as List).map((item) => item as int).toList();
    }else {
      sentRequestsIds = [];
    }
    if(jsonResponse['receivedRequestsIds'] != null) {
      receivedRequestsIds = (jsonResponse['receivedRequestsIds'] as List).map((item) => item as int).toList();
    }else {
      receivedRequestsIds = [];
    }

  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'id': id, 'username': username}
    ];
    return result;
  }

}