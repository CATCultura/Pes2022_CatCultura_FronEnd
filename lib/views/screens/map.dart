import 'dart:async';
import 'dart:ui';

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/Place.dart';
import 'package:CatCultura/viewModels/MapViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/myDrawer.dart';

// class Map extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cluster Manager Demo',
//       home: MapSample(),
//     );
//   }
// }

// Clustering maps

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapSampleState();
}

class MapSampleState extends State<Map> {
  late ClusterManager _manager;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  final CameraPosition _iniCameraPosition =
      const CameraPosition(target: LatLng(41.3874, 2.1686), zoom: 11.0);
  final MapViewModel viewModel = MapViewModel();


  @override
  void initState() {
    _manager = _initClusterManager();
    viewModel.fetchEventsListApi();
    super.initState();
  }

  ClusterManager _initClusterManager() {
    List<Place> a = [];
    return ClusterManager<Place>(a, _updateMarkers,
        markerBuilder: _markerBuilder, stopClusteringZoom: 17.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    debugPrint('Updated ${markers.length} markers');
    //_manager.setItems(viewModel.eventsList.data!);
    setState(() {
      this.markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<MapViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Google Maps Demo'),
            ),
            drawer: const MyDrawer("Map",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: viewModel.eventsList.status == Status.COMPLETED ? GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _iniCameraPosition,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _manager.setItems(viewModel.eventsList.data!);
                  _controller.complete(controller);
                  _manager.setMapId(controller.mapId);
                },
                onCameraMove: _manager.onCameraMove,
                onCameraIdle: _manager.updateMap) : const SizedBox(
              child: Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.refresh();
                viewModel.fetchEventsListApi();
              },
              child: const Icon(Icons.update),
            ),
          );
        }));
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        if(!cluster.isMultiple) {
          return Marker(
              markerId: MarkerId(cluster.getId()),
              position: cluster.location,
            infoWindow: InfoWindow(title: cluster.items.first.event.denominacio, snippet: cluster.items.first.event.descripcio, onTap: () {Navigator.pushNamed(
                context,
                "/eventUnic",
                arguments: EventUnicArgs(cluster.items.first.event.id!)
            );}),
            icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
                text: cluster.isMultiple ? cluster.count.toString() : null, color: cluster.items.last.color),
          );
        }
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,

          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
            // if(!cluster.isMultiple) Navigator.pushNamed(
            //     context,
            //     "/eventUnic",
            //     arguments: EventUnicArgs(cluster.items.first.event.id!)
            // );
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null, color: cluster.items.last.color),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text, Color? color}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    Paint paint1 = Paint()..color = Colors.red;
    if(color != null ) paint1 = Paint()..color = color;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}

