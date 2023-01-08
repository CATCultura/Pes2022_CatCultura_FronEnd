import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/viewModels/RutaCulturalViewModel.dart';
import 'package:CatCultura/views/screens/parametersRutaCultural.dart';
// import 'package:CatCultura/views/screens/savedRutesCulturals.darts';
import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SingleEventMap extends StatefulWidget {
  final EventResult event;

  SingleEventMap({required this.event});

  @override
  _SingleEventMapState createState() => _SingleEventMapState();
}

class _SingleEventMapState extends State<SingleEventMap> {
  late GoogleMapController mapController;
  late LatLng _initialcameraposition;
  late CameraPosition _kInitialPosition;

  late EventResult event;
  LatLngBounds _visibleRegion = LatLngBounds(
    southwest: const LatLng(0, 0),
    northeast: const LatLng(0, 0),
  );

  @override
  void initState() {
    super.initState();
    event = widget.event;
    _initialcameraposition = LatLng(event.latitud!, event.longitud!);
    _kInitialPosition = CameraPosition(
        target: LatLng(event.latitud!, event.longitud!), zoom: 11.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(event.denominacio!),
        ),
        body: GoogleMap(
          markers: {
            Marker(
              markerId: const MarkerId("marker"),
              position: LatLng(event.latitud!, event.longitud!),
            ),
          },
          onMapCreated: onMapCreated,
          initialCameraPosition: _kInitialPosition,
          onCameraIdle:
              _updateVisibleRegion, // https://github.com/flutter/flutter/issues/54758
        ));
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    final LatLngBounds visibleRegion = await controller.getVisibleRegion();
    setState(() {
      mapController = controller;
      _visibleRegion = visibleRegion;
    });
  }

  Future<void> _updateVisibleRegion() async {
    final LatLngBounds visibleRegion = await mapController!.getVisibleRegion();
    setState(() {
      _visibleRegion = visibleRegion;
    });
  }
}

// GoogleMap(
// initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 15),
// onMapCreated: (GoogleMapController controller){
// _controller.complete(controller);
// },
// myLocationEnabled: true,
// myLocationButtonEnabled: true,
// mapType: MapType.normal,
// compassEnabled: true,
// zoomControlsEnabled: false,
// markers: _createMarker(),
// ),
