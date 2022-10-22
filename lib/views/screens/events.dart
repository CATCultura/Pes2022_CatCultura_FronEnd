import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/eventContainer.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';

class Events extends StatelessWidget {
  Events({super.key});
  final EventsViewModel viewModel = EventsViewModel();

  void initState() {
    viewModel.fetchEventsListApi();
  }

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
              child: eventsListSwitch(viewModel: viewModel),
            ),
          );
        }));
  }
}

class eventsListSwitch extends StatefulWidget {
  final EventsViewModel viewModel;

  const eventsListSwitch({super.key, required this.viewModel});
  @override
  State<eventsListSwitch> createState() => eventsListSwitchState();
}

class eventsListSwitchState extends State<eventsListSwitch> {
  late EventsViewModel viewModel = widget.viewModel;

  void initState() {
    viewModel.fetchEventsListApi();
  }

  Widget _buildEventShort(int idx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () {
            debugPrint("clicked event: ${viewModel.eventsList.data![idx].denominacio}");
            Navigator.pushNamed(
              context,
              "/eventUnic",
                arguments: EventUnicArgs(viewModel.eventsList.data![idx].id!)
            );
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Column(children: [
            Text(viewModel.eventsList.data![idx].denominacio!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                    "${viewModel.eventsList.data![idx].dataInici!}\n${viewModel.eventsList.data![idx].dataFi!}"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.place),
                Text(viewModel.eventsList.data![idx].localitat!),
              ],
            ),
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (viewModel.eventsList.status) {
      case Status.LOADING:
        print("when eventsList is loading");
        return const SizedBox(
          child: Center(child: CircularProgressIndicator()),
        );
      case Status.ERROR:
        return Text(viewModel.eventsList.toString());
      case Status.COMPLETED:
        //viewModel.eventSelected.status = Status.LOADING;
        int numEvents = viewModel.eventsList.data!.length;
        return ListView.builder(
            itemCount: numEvents,
            itemBuilder: (BuildContext context, int i) {
              return _buildEventShort(i);
            });
      default:
        return const Text("asdfasdf");
    }
  }
}
