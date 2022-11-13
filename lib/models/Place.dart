import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'dart:math';


class Place with ClusterItem {
  final EventResult event;
  final Color color;
  //late LatLng latLng = LatLng(event.latitud!, event.longitud!);
  //final LatLng latLng = LatLng(new Random(1).nextDouble(), new Random(0).nextDouble());
  //final String name;
  //final LatLng latLng;

  Place({required this.event, required this.color});

  @override
  LatLng get location => LatLng(event.latitud!, event.longitud!);//latLng;
}