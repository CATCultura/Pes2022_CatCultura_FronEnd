import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';

import 'package:CatCultura/views/widgets/events/eventContainerAgenda.dart';

class Agenda extends StatelessWidget {
  Agenda({super.key});
  final EventsViewModel viewModel = EventsViewModel();
  String loggedUserId = '5850';

  @override
  Widget build(BuildContext context) {
    viewModel.fetchAttendanceById(loggedUserId);
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
                    viewModel.fetchAttendanceById(loggedUserId);
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
              child: viewModel.attendanceList.status == Status.LOADING? const SizedBox(
                child: Center(child: CircularProgressIndicator()),
              ):
              viewModel.attendanceList.status == Status.ERROR? Text(viewModel.attendanceList.toString()):
              viewModel.attendanceList.status == Status.COMPLETED? agendaListSwitch(assistance: viewModel.attendanceList.data!) : const Text("asdfasdf"),
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