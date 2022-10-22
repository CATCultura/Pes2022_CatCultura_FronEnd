import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/eventContainer.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';

class Events extends StatelessWidget {
  Events({super.key});
  final EventsViewModel viewModel = EventsViewModel();

  void initState() {
    debugPrint("fetching events");
  }

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
                //NO FUNCIONA
                IconButton(
                  onPressed: () {
                    viewModel.eventsList.status = Status.LOADING;
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () {
            debugPrint("clicked event: ${events[idx].denominacio}");
            Navigator.pushNamed(
              context,
              "/eventUnic",
                arguments: EventUnicArgs(events[idx].id!)
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Column(children: [
            Text(events[idx].denominacio!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                    "${events[idx].dataInici!}\n${events[idx].dataFi!}"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.place),
                Text(events[idx].localitat!),
              ],
            ),
          ])),
    );
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
