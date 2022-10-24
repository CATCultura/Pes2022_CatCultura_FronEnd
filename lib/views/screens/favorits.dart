import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';

class Favorits extends StatelessWidget {
  Favorits({super.key});
  final EventsViewModel viewModel = EventsViewModel();
  String loggedUserId = '';

  @override
  Widget build(BuildContext context) {
    viewModel.fetchFavouritesById(loggedUserId);
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Favorits"),
              backgroundColor: MyColorsPalette.red,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.fetchFavouritesById(loggedUserId);
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Favorits",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.favouritesList.status == Status.LOADING? const SizedBox(
                child: Center(child: CircularProgressIndicator()),
              ):
              viewModel.favouritesList.status == Status.ERROR? Text(viewModel.favouritesList.toString()):
              viewModel.favouritesList.status == Status.COMPLETED? favoritsListSwitch(events: viewModel.favouritesList.data!) : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class favoritsListSwitch extends StatefulWidget {
  final List<EventResult> events;

  const favoritsListSwitch({super.key, required this.events});
  @override
  State<favoritsListSwitch> createState() => favoritsListSwitchState();
}

class favoritsListSwitchState extends State<favoritsListSwitch> {
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

class EventInfoTile extends StatelessWidget {

  final EventResult event;

  const EventInfoTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () {
            debugPrint("clicked event: ${event.denominacio}");
            Navigator.pushNamed(
                context,
                "/eventUnic",
               // arguments: EventUnicArgs(event.id!)
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Column(children: [
            Text(event.denominacio!,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                    "${event.dataInici!}\n${event.dataFi!}"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.place),
                Text(event.localitat!),
              ],
            ),
          ])),
    );
  }
}
