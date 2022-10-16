import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/viewModels/EventsViewModel.dart';
import 'package:tryproject2/views/widgets/eventContainer.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

import '../../data/response/apiResponse.dart';

class Events extends StatelessWidget {
  Events({super.key});
  final EventsViewModel viewModel = EventsViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Events"),
              backgroundColor: MyColorsPalette.red,
              actions: [
                //NO FUNCIONA
                IconButton(
                  onPressed: () {viewModel.eventsList.status = Status.LOADING; viewModel.fetchEventsListApi();},
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Events",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 16),
                child: EventContainer(viewModel: viewModel),
              ),
            ),
          );
        }));
  }
}
