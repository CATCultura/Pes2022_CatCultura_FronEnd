
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/eventContainer.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';

import '../../data/response/apiResponse.dart';

class EventUnic extends StatelessWidget {
  EventUnic({super.key, required this.viewModel, required this.eventId});
  EventsViewModel viewModel;// = EventsViewModel();
  String eventId;

  // void initState() {
  //   debugPrint("hereEven");
  //   viewModel.selectEventById(eventId);
  //   debugPrint("here2");
  //
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
              appBar: AppBar(
                title: Text("EVENT UNIC"),
                backgroundColor: MyColorsPalette.red,

                actions: <Widget> [
                  new IconButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/opcions-Esdeveniment');
                      },
                      icon: Icon(Icons.settings)
                  ),
                ],
              ),
              drawer: MyDrawer(""),
              body: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: EventContainer(viewModel: viewModel, eventId: eventId),
              )
          );
        }));
  }
}