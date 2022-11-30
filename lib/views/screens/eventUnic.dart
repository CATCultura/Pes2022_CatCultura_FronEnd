import 'package:CatCultura/utils/functions/overflowFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../../../utils/functions/overflowFunctions.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/events/eventInfoShort.dart';
import '../widgets/events/eventInfoTabs.dart';

class EventUnic extends StatefulWidget {
  EventUnic({super.key, required this.eventId});
  String eventId;
  EventUnicViewModel viewModel = EventUnicViewModel();

  @override
  State<EventUnic> createState() => _EventUnicState();
}

class _EventUnicState extends State<EventUnic> {
  late String eventId = widget.eventId;
  late EventUnicViewModel viewModel = widget.viewModel;

  @override
  void initState() {
    viewModel.selectEventById(eventId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventUnicViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * .65,
                      color: Colors.blue,
                      child: viewModel.eventSelected.status == Status.LOADING? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator()),
                      ):
                      Image.network("https://agenda.cultura.gencat.cat" +
                          viewModel.eventSelected.data!.imgApp!)),
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    color: Colors.white,
                  )
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .58),
                child: Expanded(
                  child: Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        const SliverAppBar(
                          pinned: true,
                          expandedHeight: 250.0,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text('Demo'),
                          ),
                        ),
                        SliverGrid(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 4.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.teal[100 * (index % 9)],
                                child: Text('Grid Item $index'),
                              );
                            },
                            childCount: 20,
                          ),
                        ),
                        SliverFixedExtentList(
                          itemExtent: 50.0,
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.lightBlue[100 * (index % 9)],
                                child: Text('List Item $index'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // Card(
                    //   color: Colors.white,
                    //   elevation: 4.0,
                    // ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}

// class EventUnic extends StatelessWidget {
//   EventUnic({super.key, required this.eventId});
//   EventUnicViewModel viewModel = EventUnicViewModel(); // = EventsViewModel();
//   String eventId;
//
//   @override
//   void initState() {
//     // debugPrint("initializing state of EventUnic");
//     // viewModel.selectEventById(eventId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint("building EventUnic with ID: $eventId");
//     viewModel.selectEventById(eventId);
//     return ChangeNotifierProvider<EventUnicViewModel>(
//         create: (BuildContext context) => viewModel,
//         child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
//           return Scaffold(
//               appBar: AppBar(
//                 title: viewModel.eventSelected.status == Status.LOADING
//                     ? Text("...")
//                     : Center(
//                         child: FittedBox(
//                           fit: BoxFit.contain,
//                           child: //Text(
//                               getSizedText(
//                                   viewModel.eventSelected.data!.denominacio!),
//                           // overflow: TextOverflow.clip,
//                           //   style: const TextStyle(color: MyColorsPalette.white,
//                           //     fontWeight: FontWeight.bold, ),
//                           // ),
//                         ),
//                       ),
//                 backgroundColor: Color(0xFF3F3F44),
//                 actions: <Widget>[
//                   IconButton(
//                       onPressed: () {
//                         print(eventId);
//                         Navigator.popAndPushNamed(
//                             context, '/opcions-Esdeveniment',
//                             arguments: EventUnicArgs(eventId));
//                       },
//                       icon: Icon(Icons.settings)),
//                 ],
//               ),
//               //drawer: MyDrawer(""),
//               body: Container(
//                 //padding: const EdgeInsets.only(top:10.0),
//                 child: viewModel.eventSelected.status == Status.LOADING
//                     ? SizedBox(
//                         height: MediaQuery.of(context).size.height,
//                         child: const Center(child: CircularProgressIndicator()),
//                       )
//                     : viewModel.eventSelected.status == Status.ERROR
//                         ? Text(viewModel.eventSelected.toString())
//                         : viewModel.eventSelected.status == Status.COMPLETED
//                             ? Column(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     //padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 1.0),
//                                     child: Row(
//                                       children: [
//                                         //DATA-ESPAI-COMARCA
//                                         Expanded(
//                                           child: FittedBox(
//                                               fit: BoxFit.fill,
//                                               //   child: Image.network("https://agenda.cultura.gencat.cat"+event.imatges![0])),
//                                               child: Image.network(
//                                                   "https://agenda.cultura.gencat.cat" +
//                                                       viewModel.eventSelected
//                                                           .data!.imgApp!)),
//
//                                           // //flex: 4,
//                                           // child:
//                                           // EventInfoShort(event: viewModel.eventSelected.data!),
//                                         ),
//                                         //const Padding(padding: EdgeInsets.only(left: 10.0)),
//                                       ],
//                                     ),
//                                   ),
//                                   //const Padding(padding: EdgeInsets.only(top: 100.0)),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                         decoration: const BoxDecoration(
//                                             // border: Border(
//                                             //   top: BorderSide(
//                                             //     color: Colors.grey,
//                                             //     style: BorderStyle.solid,
//                                             //     width: 3,
//                                             //   ),
//                                             // ),
//                                             ),
//                                         //padding: const EdgeInsets.only(top:25.0),
//                                         //margin: const EdgeInsets.only(top: 50),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                                 child: EventInfoTabs(
//                                                     event: viewModel
//                                                         .eventSelected.data!)),
//                                           ],
//                                         )),
//                                   ),
//                                 ],
//                               )
//                             : const Text("asdfasdf"),
//
//                 //EventContainer(eventId: eventId),
//               ));
//         }));
//   }
// }
