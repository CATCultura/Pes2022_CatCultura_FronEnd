import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulMap();
  }
}

class StatefulMap extends StatefulWidget {
  const StatefulMap({super.key});

  @override
  State<StatefulMap> createState() => _StatefulMapState();
}

class _StatefulMapState extends State<StatefulMap> {
  late LatLng currentLatLng = LatLng(41.383333, 2.183333);
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
    });
    return;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Current Location --------> ${currentLatLng.latitude} ${currentLatLng.longitude}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Demo'),
      ),
      drawer: const MyDrawer("Map",
          username: "Superjuane", email: "juaneolivan@gmail.com"),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 5),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: <Marker>{
          Marker(
            draggable: true,
            markerId: const MarkerId("1"),
            position: currentLatLng,
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(
              title: 'My Location',
            ),
          )
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _determinePosition,
        label: const Text('Home'),
        icon: const Icon(Icons.home),
      ),
    );
  }
}
