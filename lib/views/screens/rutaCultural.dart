import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/Place.dart';
import 'package:CatCultura/viewModels/RutaCulturalViewModel.dart';
import 'package:CatCultura/views/screens/parametersRutaCultural.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';

import '../../utils/auxArgsObjects/argsRouting.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import '../widgets/myDrawer.dart';

var GLOBAL_OPEN = false;

class RutaCultural extends StatefulWidget {
  @override
  State<RutaCultural> createState() => RutaCulturalState();
}

class RutaCulturalState extends State<RutaCultural> {
  late ClusterManager _manager;
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _saveNameController = TextEditingController();
  TextEditingController _saveDescController = TextEditingController();

  final RutaCulturalViewModel viewModel = RutaCulturalViewModel();

  @override
  void initState() {
    _manager = _initClusterManager();
    GLOBAL_OPEN = false;
    super.initState();
  }

  ClusterManager _initClusterManager() {
    List<Place> a = [];
    return ClusterManager<Place>(a, _updateMarkers,
        markerBuilder: _markerBuilder, stopClusteringZoom: 1.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    //debugPrint("markers to set: "+markers.toString());
    setState(() {
      viewModel.markers = markers; //await setMarkers(markers);
    });
  }

  final _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RutaCulturalViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<RutaCulturalViewModel>(builder: (context, value, _) {
          return Scaffold(
                appBar: AppBar(
                  title: const Text('RUTA CULTURAL'),
                ),
                drawer: const MyDrawer("rutaCultural",
                    username: "Superjuane", email: "juaneolivan@gmail.com"),
                body: viewModel.eventsListMap.status == Status.LOADING &&
                        viewModel.rutaGenerada
                    ? SizedBox(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Estem generant la teva ruta...",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            )
                          ],
                        )),
                      )
                    : viewModel.eventsListMap.status == Status.COMPLETED &&
                            viewModel.polylines.status == Status.COMPLETED
                        ? GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: viewModel.iniCameraPosition,
                            markers: viewModel.markers,
                            polylines:
                                Set<Polyline>.of(viewModel.polylines.data!.values),
                            onMapCreated: (GoogleMapController controller) {
                              //for(Place p in viewModel.eventsListMap.data!) debugPrint("   Event: ${p.event.id}");
                              if (!_controller.isCompleted)
                                _controller.complete(controller);
                              _manager.setMapId(controller.mapId);
                              _manager.setItems(viewModel.eventsListMap.data!);
                              _manager.updateMap();
                            },
                            onCameraMove: _manager.onCameraMove,
                            onCameraIdle: _manager.updateMap)
                        : GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: viewModel.iniCameraPosition,
                            markers: viewModel.markers,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              //_manager.setMapId(controller.mapId);
                            },
                            //onCameraMove: _manager.onCameraMove,
                            //onCameraIdle: _manager.updateMap),
                          ),
                floatingActionButton: ExpandableFab(
                  distance: 112.0,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        _navigateAndDisplayRouteGeneratorSelector(context);
                      },
                      label: Text('Generar Ruta Cultural'),
                    ),
                    viewModel.rutaGenerada? FloatingActionButton.extended(
                      onPressed: () {
                        RutaCulturalSaveArgs args =
                            RutaCulturalSaveArgs(null, null, true);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.lightBlue,
                              icon: const Icon(Icons.save),
                              iconColor: Colors.white,
                              title: Container(decoration: BoxDecoration(color: Colors.lightBlue), child: Text("GUARDAR RUTA CULTURAL", style: TextStyle(color: Colors.white),)),
                              content: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(8.0)),),
                                    padding: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0),
                                    child: TextField(
                                      maxLength: 25,
                                      onChanged: (value) {
                                        args.name = value;
                                      },
                                      controller: _saveNameController,
                                      decoration:
                                          InputDecoration(hintText: "Nom"),
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(8.0)),),
                                    padding: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0),
                                    child: TextField(
                                      maxLines: 3,
                                      onChanged: (value) {
                                        args.description = value;
                                      },
                                      controller: _saveDescController,
                                      decoration: InputDecoration(hintText: "Descripció"),
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(8.0)),),
                                      padding: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0),
                                      child: ListView.builder(
                                          itemCount: viewModel
                                              .eventsList
                                              .data!
                                              .length,
                                          itemBuilder:
                                              (BuildContext context,
                                              int i) {
                                            return Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Material(
                                                elevation: 20,
                                                shadowColor: Colors.black.withAlpha(70),

                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                child: ListTile(

                                                    onTap: () {
                                                      debugPrint("clicked event: ${viewModel
                                                          .eventsList
                                                          .data![i].denominacio}");
                                                      Navigator.pushNamed(context, "/eventUnic",
                                                          arguments: EventUnicArgs(viewModel
                                                              .eventsList
                                                              .data![i].id!)).then((_){
                                                        /*setState((){

                        });*/
                                                      });
                                                    },
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(color: Color(0xFF818181), width: 1),
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    tileColor: Colors.lightBlue,
                                                    title: Column(children: [
                                                      Text(viewModel
                                                          .eventsList
                                                          .data![i].denominacio!,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                              fontSize: 15)),
                                                    ])),
                                              ),
                                            );
                                            // (
                                            //   event: viewModel
                                            //       .eventsList
                                            //       .data![i],
                                            //   index: i,
                                            // );
                                          }),
                                    ),
                                  ),

                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.white)),
                                  child: Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.pop(context, args);
                                  },
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.white)),
                                  child: Text('SAVE'),
                                  onPressed: () {
                                    args.canceled = false;
                                    Navigator.pop(context, args);
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((val) async {
                          debugPrint(
                              "-------------------- printing value from save popUp() --------- \nname: ${val.name}, desc: ${val.description}");
                          if (!val.canceled){
                            debugPrint("NOT CANCELED");
                            setState(() {
                              viewModel.savingRuta = true;
                            });
                            await viewModel.saveRutaCultural(args).then((_){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('SE HA GUARDADO LA RUTA'),
                                    content: Text(viewModel.savingRutaMsg),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                            _saveNameController = TextEditingController();
                            _saveDescController = TextEditingController();
                          }
                        });
                      },
                      label: Text('Guardar Ruta Actual'),
                    ): SizedBox(width: 0, height: 0,),
                    FloatingActionButton.extended(
                      onPressed: () {
                        _showAction(context, 0);
                      },
                      label: Text('Obrir Rutes Guardades'),
                    ),
                  ],
                ),
              );
        }));
  }

  Future<void> _navigateAndDisplayRouteGeneratorSelector(
      BuildContext context) async {
    setState(() {
      viewModel.rutaGenerada = false;
    });
    final result = await Navigator.push(
      context,
      MaterialPageRoute<RutaCulturalArgs>(
          builder: (context) => const ParametersRutaCultural()),
    );
    if (!mounted) return;
    setState(() {
      viewModel.rutaGenerada = true;
    });
    viewModel.polylines =
        ApiResponse(Status.LOADING, <PolylineId, Polyline>{}, null);
    await viewModel.generateRutaCultural(result).then((value) => {});
    //viewModel.paintRoute();
    // setState(() {
    //
    // });
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        //debugPrint("ENTRO EN MARKER BUILDER");
        if (!cluster.isMultiple) {
          //debugPrint("cluster is simple");
          return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            infoWindow: InfoWindow(
                title: cluster.items.first.event.denominacio!,
                snippet: cluster.items.first.event.descripcio!,
                onTap: () {
                  Navigator.pushNamed(context, "/eventUnic",
                      arguments: EventUnicArgs(cluster.items.first.event.id!));
                }),
            icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
                text: '!', color: cluster.items.last.color),
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

  // Create the polylines for showing the route between two places

}

// class DisplayTextInputDialog(BuildContext context) {
//   RutaCulturalSaveArgs args = RutaCulturalSaveArgs(null, null, null);
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _descrriptionController = TextEditingController();
//
//   // @override
//   // Widget build (BuildContext context) {
//     return AlertDialog(
//       title: Text('TextField in Dialog'),
//       content: Column(
//         children: [
//           TextField(
//             onChanged: (value) {
//               args.name = value;
//             },
//             controller: _nameController,
//             decoration: InputDecoration(hintText: "name in Dialog"),
//           ),
//           TextField(
//             onChanged: (value) {
//               args.description = value;
//             },
//             controller: _descrriptionController,
//             decoration: InputDecoration(hintText: "desc"),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.red),
//               foregroundColor: MaterialStateProperty.all(Colors.white)),
//           child: Text('CANCEL'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         TextButton(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.green),
//               foregroundColor: MaterialStateProperty.all(Colors.white)),
//           child: Text('OK'),
//           onPressed: () {
//             args.cancel = false;
//             Navigator.pop(context, args);
//           },
//         ),
//       ],
//     );
//   // }
// }

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    GLOBAL_OPEN = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: GLOBAL_OPEN ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      GLOBAL_OPEN = !GLOBAL_OPEN;
      if (GLOBAL_OPEN) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 50.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: GLOBAL_OPEN,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          GLOBAL_OPEN ? 0.7 : 1.0,
          GLOBAL_OPEN ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: GLOBAL_OPEN ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: -45.0 + offset.dx,
          bottom: 1.0 + offset.dy * 1.5,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
