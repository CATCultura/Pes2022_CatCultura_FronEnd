
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/viewModels/EventsViewModel.dart';
import 'package:tryproject2/views/widgets/eventContainer.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

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
              appBar: AppBar(title: Text("EVENT UNIC"), backgroundColor: MyColorsPalette.red,),
              drawer: MyDrawer(""),
              body: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: EventContainer(viewModel: viewModel, eventId: eventId),
              )
          );
        }));
  }
}