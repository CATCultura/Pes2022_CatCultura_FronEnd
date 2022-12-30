import 'dart:core';
import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';

class RouteResult {
  String? name = "NO_NAME";
  String? description = "NO_DESCRIPTION";
  String? date = "NO_DATE";
  //List<int>? eventIds = [];
  List<EventResult>? events = [];

  RouteResult({
    this.name,
    this.description,
    this.date,
    //this.eventIds,
    this.events,
  });

  RouteResult.fromJson(Map<String, dynamic> jsonResponse) {
    name = jsonResponse['name'];
    description = jsonResponse['description'];
    date = jsonResponse['createdAt'];
    //eventIds = jsonResponse['eventIds'];
    if (jsonResponse['routeEvents'] != null) {
      events = List.from(jsonResponse['routeEvents'].map((e) => EventResult.fromJson(e)).toList());
    }
    else{
      events = [];
    }
  }
}
