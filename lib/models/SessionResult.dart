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
    this.friendsId
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
    favouritesId = (jsonResponse['favouriteEvents'] as List).map((item) => item as int).toList();
    trophiesId = (jsonResponse['trophiesReceived'] as List).map((item) => item as int).toList();
    attendanceId = (jsonResponse['eventsAttendance'] as List).map((item) => item as int).toList();
    if(jsonResponse['friendsIds'] != null) {
      friendsId = (jsonResponse['friendsIds'] as List).map((item) => item as int).toList();
    }else {
      friendsId = [];
    }
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'id': id, 'username': username}
    ];
    return result;
  }

}