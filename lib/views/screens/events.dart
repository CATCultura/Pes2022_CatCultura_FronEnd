import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../widgets/events/eventInfoTile.dart';

class Events extends StatelessWidget {
  Events({super.key});
  final EventsViewModel viewModel = EventsViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.fetchEventsListApi();
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Events"),
              backgroundColor: MyColorsPalette.red,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.fetchEventsListApi();
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Events",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.eventsList.status == Status.LOADING? const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          ):
                      viewModel.eventsList.status == Status.ERROR? Text(viewModel.eventsList.toString()):
                      viewModel.eventsList.status == Status.COMPLETED? eventsListSwitch(events: viewModel.eventsList.data!) : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class eventsListSwitch extends StatefulWidget {
  final List<EventResult> events;

  const eventsListSwitch({super.key, required this.events});
  @override
  State<eventsListSwitch> createState() => eventsListSwitchState();
}

class eventsListSwitchState extends State<eventsListSwitch> {
  late List<EventResult> events = widget.events;

  Widget _buildEventShort(int idx) {
    return EventInfoTile(event: events[idx]);
  }

  @override
  Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int i) {
              return _buildEventShort(i);
            });

    }
}
