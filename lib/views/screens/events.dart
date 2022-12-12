import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../models/Place.dart';
import '../widgets/events/eventInfoTile.dart';

/*class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}

class HomePage extends State<MainPage>{
 //Your code here
}*/

class Events extends StatefulWidget {
  Events({super.key});
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> with SingleTickerProviderStateMixin {
  final EventsViewModel viewModel = EventsViewModel();
  late ScrollController _scrollController;
  late TabController _tabController;
  bool findedSomething = false;
  String message = "Search by name...";
  var searchResult;
  late ClusterManager _manager;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  final CameraPosition _iniCameraPosition =
      const CameraPosition(target: LatLng(41.3874, 2.1686), zoom: 11.0);

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        viewModel.addNewPage();
        //_manager.setItems(viewModel.eventsListMap.data!);
      });
    }
  }

  ClusterManager _initClusterManager() {
    List<Place> a = [];
    return ClusterManager<Place>(a, _updateMarkers,
        markerBuilder: _markerBuilder,
        stopClusteringZoom: 17.0,
        levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0]);
  }

  void _updateMarkers(Set<Marker> markers) {
    debugPrint('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  void initState() {
    viewModel.fetchEvents();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _manager = _initClusterManager();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          debugPrint("lista!!!!!!!!!!!");
          break;
        case 1:
          debugPrint("mapa!!!!!!!!!!!");
          // _manager = _initClusterManager();
          // (GoogleMapController controller) {
          //   _manager.setItems(viewModel.eventsListMap.data!);
          //   //_controller.complete(controller);
          //   _manager.setMapId(controller.mapId);
          // };
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red.shade900,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              height: AppBar().preferredSize.height / 2,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 5, bottom: 5, right: 5),
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(105, 105, 105, 0.6),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                          )
                          // Container(
                          //   width: double.infinity,
                          //   color: Colors.blue,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(color: Colors.blue,),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    final searchQueryResult = await showSearch(
                      context: context,
                      delegate: SearchEvents(
                        suggestedEvents: viewModel.suggestions,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    if (viewModel.suggestions.contains(searchQueryResult)) {
                      debugPrint(searchQueryResult);
                      Navigator.pushNamed(context, '/eventUnic',
                          arguments: EventUnicArgs(searchQueryResult!));
                    } else if (searchQueryResult != null &&
                        searchQueryResult != '') {
                      message = searchQueryResult;
                      findedSomething = true;
                      debugPrint(searchQueryResult);
                      viewModel.setLoading();
                      viewModel.redrawWithFilter(searchQueryResult);
                      //Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(finalResult!));
                    }
                  }),
              backgroundColor: MyColorsPalette.red,
              actions: [
                findedSomething == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            message = "Search by name...";
                            findedSomething = false;
                          });
                          viewModel.refresh();
                          viewModel.fetchEvents();
                        },
                        icon: const Icon(Icons.close),
                      )
                    : const SizedBox.shrink(),
                IconButton(
                  onPressed: () {
                    viewModel.refresh();
                    viewModel.fetchEvents();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Events",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            /**/
            body: DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.red.shade800,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(icon: Icon(Icons.list)),
                            Tab(icon: Icon(Icons.map)),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: <Widget>[
                            Center(
                              child: viewModel.eventsList.status ==
                                      Status.LOADING
                                  ? const SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : viewModel.eventsList.status == Status.ERROR
                                      ? Text(viewModel.eventsList.toString())
                                      : viewModel.eventsList.status ==
                                              Status.COMPLETED
                                          ? Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                      controller:
                                                          _scrollController,
                                                      itemCount: viewModel
                                                          .eventsList
                                                          .data!
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return EventInfoTile(
                                                          event: viewModel
                                                              .eventsList
                                                              .data![i],
                                                          index: i,
                                                        );
                                                      }),
                                                ),
                                                viewModel.chargingNextPage
                                                    ? const SizedBox(
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            )
                                          : const Text("asdfasdf"),
                            ),
                            Center(
                              child: viewModel.eventsListMap.status ==
                                      Status.COMPLETED
                                  ? GoogleMap(
                                      mapType: MapType.normal,
                                      initialCameraPosition: _iniCameraPosition,
                                      markers: markers,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        if (!_controller.isCompleted) {
                                          _manager.setItems(viewModel.eventsListMap.data!);
                                          _controller.complete(controller);
                                          _manager.setMapId(controller.mapId);
                                        } else {
                                          _manager.setItems(viewModel.eventsListMap.data!);
                                          _manager.setMapId(controller.mapId);
                                        }
                                      },
                                      onCameraMove: _manager.onCameraMove,
                                      onCameraIdle: _manager.updateMap)
                                  : const SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                            ),
                          ]))
                    ])),
          );
        }));
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        if (!cluster.isMultiple) {
          return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            infoWindow: InfoWindow(
                title: cluster.items.first.event.denominacio,
                snippet: cluster.items.first.event.descripcio,
                onTap: () {
                  Navigator.pushNamed(context, "/eventUnic",
                      arguments: EventUnicArgs(cluster.items.first.event.id!));
                }),
            icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
                text: cluster.isMultiple ? cluster.count.toString() : null,
                color: cluster.items.last.color),
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
              text: cluster.isMultiple ? cluster.count.toString() : null,
              color: cluster.items.last.color),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size,
      {String? text, Color? color}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    Paint paint1 = Paint()..color = Colors.red;
    if (color != null) paint1 = Paint()..color = color;
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class SearchEvents extends SearchDelegate<String> {
  final List<String> suggestedEvents;

  SearchEvents({required this.suggestedEvents});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        query = '';
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> usersSuggList = suggestedEvents
        .where(
          (userSugg) => userSugg.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: usersSuggList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(usersSuggList[index]),
        onTap: () {
          query = usersSuggList[index];
          close(context, query);
        },
      ),
    );
  }
}
