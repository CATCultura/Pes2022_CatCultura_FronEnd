import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';

import 'package:CatCultura/views/widgets/eventContainerAgenda.dart';

class Agenda extends StatelessWidget {
  Agenda({super.key});
  final EventsViewModel viewModel = EventsViewModel();
  String loggedUserId = '5750';

  @override
  Widget build(BuildContext context) {
    viewModel.fetchAssistanceById(loggedUserId);
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Agenda"),
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
            drawer: const MyDrawer("Agenda",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.assistanceList.status == Status.LOADING? const SizedBox(
                child: Center(child: CircularProgressIndicator()),
              ):
              viewModel.assistanceList.status == Status.ERROR? Text(viewModel.assistanceList.toString()):
              viewModel.assistanceList.status == Status.COMPLETED? agendaListSwitch(assistance: viewModel.assistanceList.data!) : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class agendaListSwitch extends StatefulWidget {
  final List<EventResult> assistance;

  const agendaListSwitch({super.key, required this.assistance});
  @override
  State<agendaListSwitch> createState() => agendaListSwitchState();
}

class agendaListSwitchState extends State<agendaListSwitch> {
  late List<EventResult> events = widget.assistance;

  Widget _buildEventShort(int idx) {
    return EventContainerAgenda(event: events[idx]);
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