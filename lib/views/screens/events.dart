import 'dart:async';
import 'dart:ui';

import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googleapis/appengine/v1.dart' as appengine;
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';

import '../../models/Place.dart';
import '../../utils/Session.dart';
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
  GoogleMapController? mapController;

  bool findedSomething = false;

  var searchResult;
  late ClusterManager _manager;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  void getPos() async{
    debugPrint("--------getting ubi------------------");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      viewModel.realPosition = value;
      debugPrint("you are in "+viewModel.realPosition.longitude.toString()+" "+viewModel.realPosition.latitude.toString());
      //viewModel.iniCameraPosition = CameraPosition(target: LatLng(viewModel.realPosition.latitude, viewModel.realPosition.longitude), zoom: 7.0);
      setState(() {
        viewModel.iniCameraPosition = CameraPosition(target: LatLng(viewModel.realPosition.latitude, viewModel.realPosition.longitude), zoom: 13);
        mapController!.animateCamera(CameraUpdate.newCameraPosition(viewModel.iniCameraPosition));
      });
      viewModel.located = true;
    });
  }

  _scrollListener() {
    if(viewModel.eventsSimilars.status != Status.COMPLETED){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          viewModel.addNewPage();
          //_manager.setItems(viewModel.eventsListMap.data!);
        });
      }
    }
  }

  ClusterManager _initClusterManager() {
    List<Place> a = [];
    return ClusterManager<Place>(a, _updateMarkers,
        markerBuilder: _markerBuilder,
        stopClusteringZoom: 14,
      levels:[1, 5, 10, 12, 13, 13.5, 14, 14.5, 15, 15.5, 17]
      // levels: [1, 1.5, 2, 2.5, 6, 6.5, 7, 7.5, 8, 8.5, 9],
      //   levels: [1, 4.25, 6.75, 8.25, 11.33, 11.5, 12.04,12.89, 13.37, 13.76, 14.5, 14.85, 15.23, 15.89, 16.0, 16.25, 16.5, 16.75, 17.0, 17.37, 18.48, 20.0]
      // levels: [1, 4.25, 6.75, 8.25, 11.33798, 11.5, 11.75, 12.0, 12.25, 12.5, 12.75, 13.0, 13.25, 13.5, 13.75, 14.0, 14.25, 14.5, 14.75, 15.0, 15.25, 15.5, 15.75, 16.0, 16.25, 16.5, 16.75, 17.0, 17.25, 17.5, 17.75, 18.0, 18.25, 18.5, 18.75, 20.0]
    );
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
          setState(() {
            viewModel.locatedButton = false;
          });
          break;
        case 1:
          setState(() {
            viewModel.locatedButton = true;
          });
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
                          color: Colors.white,
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
                                      left: 0, top: 5, bottom: 5, right: 5),
                                  child: Text(
                                    viewModel.userUsedFilter ? viewModel.message : AppLocalizations.of(context)!.searchByQueryPrompt,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14,
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
                    // if (viewModel.suggestions.contains(searchQueryResult)) {
                    //   debugPrint(searchQueryResult);
                    //   Navigator.pushNamed(context, '/eventUnic',
                    //       arguments: EventUnicArgs(searchQueryResult!));
                    // } else
                      if (searchQueryResult != null &&
                        searchQueryResult != '') {
                      // setState(() {
                        //viewModel.message = searchQueryResult;
                      // });
                      viewModel.userUsedFilter = true;
                      debugPrint(searchQueryResult);
                      viewModel.setLoading();
                      viewModel.redrawWithFilter(searchQueryResult);
                      //Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(finalResult!));
                    }
                  }),
              backgroundColor: Colors.redAccent,
              actions: [
                viewModel.userUsedFilter == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            viewModel.message = AppLocalizations.of(context)!.searchByQueryPrompt;
                            viewModel.userUsedFilter = false;
                          });
                          viewModel.refresh();
                          viewModel.fetchEvents();
                        },
                        icon: const Icon(Icons.close),
                      )
                    : Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("OrderBy"),
                                content: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Alphabetically (asc.)"),
                                      onTap: (){
                                        viewModel.orderByAlphabetUp();
                                        _scrollController.animateTo(
                                          0.0,
                                          curve: Curves.easeInOut,
                                          duration: const Duration(seconds: 2),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Alphabetically (desc.)"),
                                      onTap: (){
                                        viewModel.orderByAlphabetDown();
                                        _scrollController.animateTo(
                                          0.0,
                                          curve: Curves.easeInOut,
                                          duration: const Duration(seconds: 2),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    // ListTile(
                                    //   title: Text("Falta (asc.)"),
                                    //   onTap: (){
                                    //     viewModel.orderByDateUp();
                                    //     Navigator.pop(context);
                                    //   },
                                    // ),
                                    ListTile(
                                      title: Text("Pròximament... (desc.)"),
                                      onTap: (){
                                        viewModel.orderByDateDown();
                                        _scrollController.animateTo(
                                          0.0,
                                          curve: Curves.easeInOut,
                                          duration: const Duration(seconds: 2),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),

                              );
                            });

                          },
                          icon: const Icon(Icons.sort_by_alpha),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  backgroundColor: Colors.red.shade800,
                                  iconColor: MyColorsPalette.white,
                                  icon: const Icon(Icons.filter_alt_outlined),
                                  title: Text("Filter by", style: TextStyle(color: MyColorsPalette.white),),
                                  content: viewModel.tags.status == Status.COMPLETED ?
                                   Container(
                                     decoration: BoxDecoration(
                                       color: MyColorsPalette.white,
                                       borderRadius: BorderRadius.circular(10)
                                     ),
                                     child: ListView.builder(
                                       itemCount: viewModel.tags.data!.length,
                                       itemBuilder: (context, index){
                                         return ListTile(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(viewModel.tags.data![index]),
                                                viewModel.tagsUsuari.contains(viewModel.tags.data![index]) ? Icon(Icons.star, color: Colors.yellowAccent,) : SizedBox.shrink(),
                                              ],
                                            ),
                                            onTap: (){
                                              viewModel.setLoading();
                                              viewModel.redrawWithTagFilter(viewModel.tags.data![index]);
                                              Navigator.pop(context);
                                            },
                                          );

                                           },

                                     ),
                                   )
                                      : const Center(child: CircularProgressIndicator(color: MyColorsPalette.white,)),
                                  // actions: [
                                  //   TextButton(
                                  //     onPressed: () {
                                  //       Navigator.pop(context);
                                  //     },
                                  //     child: Text("AppLocalizations.of(context)!.filterDialogCancel"),
                                  //   ),
                                  //   TextButton(
                                  //     onPressed: () {
                                  //       Navigator.pop(context);
                                  //       // viewModel.redrawWithTagFilter(filter);
                                  //     },
                                  //     child: Text("AppLocalizations.of(context)!.filterDialogOk"),
                                  //   ),
                                  // ],
                                );
                              });
                            },
                            icon: const Icon(Icons.filter_alt_outlined),
                          ),
                      ],
                    ),
                IconButton(
                  onPressed: () {
                    viewModel.refresh();
                    viewModel.fetchEvents();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            // key: _scaffoldKey,
            drawer: MyDrawer("Events",  Session(), ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: viewModel.located && viewModel.locatedButton ? FloatingActionButton.extended(
              heroTag: 'eventosCerca',
              onPressed: () async {
                await viewModel.getEventsNearMe().then((_){
                  // _manager.updateMap();
                  _manager.setItems(viewModel.eventsListMap.data!);
                  mapController!.animateCamera(CameraUpdate.newCameraPosition(viewModel.iniCameraPosition));

                });
              },
             backgroundColor: MyColorsPalette.red.withOpacity(0.5),
              label: Text('Buscar eventos cerca', style: TextStyle(fontSize: 10),),
            ): SizedBox.shrink(),
            body: DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.redAccent,
                          unselectedLabelColor: Colors.grey,
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
                                          ? !viewModel.userUsedFilter
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
                                                              (BuildContext
                                                                      context,
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
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    viewModel.eventsSimilars.data!.length != 0 ? Expanded(
                                                      child: ListView.builder(
                                                          controller: _scrollController,
                                                          itemCount: viewModel.eventsSimilars.data!.length,
                                                          itemBuilder: (BuildContextcontext, int i) {
                                                            return EventInfoTile(
                                                              event: viewModel.eventsSimilars.data![i],
                                                              index: i,
                                                            );
                                                          }),
                                                    ):SizedBox(width: 0, height: 0,),
                                                    const SizedBox(height: 20,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:12.0),
                                                      child: Center(
                                                        child:Column(
                                                          children: [
                                                            Text("         EVENTS SIMILARS          ",
                                                                style:TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w300,
                                                                  backgroundColor: Colors.black12,
                                                                  letterSpacing: 4,
                                                                )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 13,),
                                                    Expanded(
                                                      child: ListView.builder(
                                                          controller: _scrollController,
                                                          itemCount: viewModel.eventsNoSimilars.data!.length,
                                                          itemBuilder: (BuildContextcontext, int i) {
                                                            return EventInfoTile(
                                                              event: viewModel.eventsNoSimilars.data![i],
                                                              index: i,
                                                              mode: "noSimilar",
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                )
                                          : const Text("asdfasdf"),
                            ),
                            Center(
                              child: viewModel.eventsListMap.status ==
                                      Status.COMPLETED
                                  ? GoogleMap(
                                      zoomControlsEnabled: false,
                                      myLocationEnabled: true,
                                      mapType: MapType.normal,
                                      initialCameraPosition: viewModel.iniCameraPosition,
                                      markers: markers,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        if (!_controller.isCompleted) {
                                          // setState(() {
                                            mapController = controller;
                                          // });
                                          _controller.complete(mapController);
                                          _manager.setItems(viewModel.eventsListMap.data!);
                                          _manager.setMapId(controller.mapId);
                                        } else {
                                          _manager.setItems(viewModel.eventsListMap.data!);
                                          _manager.setMapId(controller.mapId);
                                        }
                                        // setState(() {
                                        //   mapController = controller;
                                        // });
                                        // _controller.complete(mapController);
                                        // if(viewModel.realPosition != null){
                                        //   setState(() {
                                        getPos();
                                          // });
                                        // }

                                        // _manager.setMapId(controller.mapId);
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
    return ListTile(
      title: Text(query),
        onTap: () {
          close(context, query);
        }
    );
    close(context, query);

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
