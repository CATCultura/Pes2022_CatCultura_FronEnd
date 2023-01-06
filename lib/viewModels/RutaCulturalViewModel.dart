import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/utils/Session.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/src/cluster_item.dart';
import 'package:google_maps_cluster_manager/src/cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Place.dart';
import '../models/RouteResult.dart';
import 'package:CatCultura/utils/routes/deepLinkParams.dart';


class RutaCulturalViewModel with ChangeNotifier {

  //INI
  // final CameraPosition iniCameraPosition = const CameraPosition(target: LatLng(42.0, 1.6), zoom: 7.2);
  late CameraPosition iniCameraPosition = const CameraPosition(target: LatLng(41.37, 2.16), zoom: 12.0);
  late Position realPosition;



  //VARIABLES
  final _eventsRepo = EventsRepository();
  ApiResponse<List<EventResult>> eventsList = ApiResponse.loading();
  ApiResponse<List<Place>> eventsListMap = ApiResponse.loading();
  final Session session = Session();

  //MAP {markers, lines...}
  Set<Marker> markers = {};
  // List<LatLng> polylineCoordinates = [];
  ApiResponse<Map<PolylineId, Polyline>> polylines = ApiResponse(Status.LOADING, <PolylineId, Polyline>{}, null) ;
  PolylineId? selectedPolyline;
  //late PolylinePoints polylinePoints;
  String googleAPiKey = "AIzaSyAC-HdDDHsSjsvdpvVBoqhDHaGI0khcdyo";

  //STATES
  bool rutaGenerada = false;
  bool savingRuta = false;
  String savingRutaMsg = "--";
  var code;
  bool urlParamsToUse = false;

  void iniDeepLinkRoute(ClusterManager<ClusterItem> manager) {
    if($Params != null){
      code = $Params; //![0].value.first;
      urlParamsToUse = true;
      loadSingleRoute(manager);
    }
    debugPrint("code arribes: $code");
  }

  void mantaintEventsListToMap() {
    List<Place> aux = [];
    aux.add(Place(event: EventResult(id: "1", denominacio: "YOU", descripcio: "You are here", latitud:realPosition.latitude , longitud: realPosition.longitude), color: Colors.red));
    eventsList.data!.forEach((e) {aux.add(Place(event: e, color: Colors.blue));});
    eventsListMap = ApiResponse.completed(aux);
  }

  setEventsList(ApiResponse<List<EventResult>> response){
    // if(response.data != null) response.data!.add(EventResult(id: "1", denominacio: "harcoded marker", descripcio: "sustituto de User Loc", latitud: 41.375, longitud: 2.176));
    eventsList = response;
    mantaintEventsListToMap();
    //paintRoute();
    //notifyListeners();
  }

  Future<void> saveRutaCultural(RutaCulturalSaveArgs args) async{
    // await Future.delayed(Duration(seconds: 2)).then((_){
    //     //   notifyListeners();
    //     // });ç
    String n, d;
    if(args.name == null){n = "NO_NAME";}else{n = args.name!;}
    if(args.name == null){d = "NO_DESCRIPTION";}else{d = args.description!;}
    await _eventsRepo.saveRutaCultural(name: n, description: d, events: eventsList.data!).then((value){
      savingRutaMsg = "tot ok";
      notifyListeners();
    }).onError((error, stackTrace) {
      savingRutaMsg=error.toString();
      notifyListeners();
    });
  }

  Future<void> generateRutaCultural(RutaCulturalArgs? args) async {
    eventsListMap.status = Status.LOADING;
    notifyListeners();
    await _eventsRepo.getRutaCultural(args!.longitud,args.latitud,args.radio, args.data).then ((value) async {
      setEventsList(ApiResponse.completed(value));
      await paintRoute().then((value){
        polylines.status = value;
        notifyListeners();
      });
    }).onError((error, stackTrace) =>
        setEventsList(ApiResponse.error(error.toString())));
  }

  Future<bool> loadRutaCultural(RutaCulturalLoadArgs result) async {
    if(result.events != null && result.events != []){
      setEventsList(ApiResponse.completed(result.events));
      await paintRoute().then((value){
        polylines.status = value;
        notifyListeners();
      });
      return true;
    }
    return false;
  }

  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      Color c,
      int nId,
      ) async {
    // Initializing PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    List<LatLng> polylineCoordinates = [];

    if (result.points.isNotEmpty) {
      //polylineCoordinates = [];
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    String polyIDx = "polyID+$nId";
    // Defining an ID
    PolylineId id = PolylineId(polyIDx);

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: c,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines.data![id] = polyline;
  }

  Future<Status> paintRoute() async {
    List<Color> c = [Colors.blue, Colors.red, Colors.green];
    for(int i = 0; i < /*2*/eventsListMap.data!.length - 1; ++i) {
      _createPolylines(eventsListMap.data![i].location.latitude,
          eventsListMap.data![i].location.longitude,
          eventsListMap.data![i+1].location.latitude,
          eventsListMap.data![i+1].location.longitude,c[i],i);
    }
    return Status.COMPLETED;
  }

  Future<void> loadSingleRoute(ClusterManager<ClusterItem> manager) async{
    debugPrint("loading shared route");
    await _eventsRepo.getRouteById(code).then((value) async {
      if(value != null){
        //rutaGenerada = false;
        eventsListMap.status = Status.LOADING;
        notifyListeners();
        polylines = ApiResponse(Status.LOADING, <PolylineId, Polyline>{}, null);
        if(value.events != null && value.events != []){
          setEventsList(ApiResponse.completed(value.events));
          manager.setItems(eventsListMap.data!);
          await paintRoute().then((value){
            polylines.status = value;
            notifyListeners();
          });
        }
      }
    }
    ).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      //setEventsList(ApiResponse.error(error.toString()));
    });
  }


}