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
  var searchResult;

  void iniState() {
    viewModel.fetchEventsListApi();
    //viewModel.save10Suggestions();
  }

  @override
  Widget build(BuildContext context) {
    iniState();
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: ElevatedButton(
                child: Text("BUTON"),
                onPressed: () async {
                  final finalResult = await showSearch(
                    context: context,
                    delegate: SearchEvents(
                      suggestedEvents: viewModel.suggestions,
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  if (finalResult != '') debugPrint(finalResult);
                  //Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(finalResult!));
                },
              ),
              backgroundColor: MyColorsPalette.red,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.refresh();
                    viewModel.fetchEventsListApi();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Events",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.eventsList.status == Status.LOADING
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : viewModel.eventsList.status == Status.ERROR
                      ? Text(viewModel.eventsList.toString())
                      : viewModel.eventsList.status == Status.COMPLETED
                          ? EventsListSwitch(events: viewModel.eventsList.data!)
                          : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class SearchEvents extends SearchDelegate<String> {
  final List<String> suggestedEvents;

  SearchEvents({required this.suggestedEvents});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
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
    close(context, query);
    return Container();
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

class EventsListSwitch extends StatefulWidget {
  final List<EventResult> events;

  const EventsListSwitch({super.key, required this.events});
  @override
  State<EventsListSwitch> createState() => EventsListSwitchState();
}

class EventsListSwitchState extends State<EventsListSwitch> {
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
