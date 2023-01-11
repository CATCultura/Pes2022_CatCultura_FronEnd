import 'package:CatCultura/views/widgets/events/eventInfoTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/AgendaViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'package:CatCultura/views/widgets/events/eventContainerAgenda.dart';

import '../../utils/Session.dart';

class AttendanceEvents extends StatefulWidget {
  AttendanceEvents({super.key});
  final AgendaViewModel viewModel = AgendaViewModel();

  @override
  State<AttendanceEvents> createState() => _AttendanceEventsState();
}

class _AttendanceEventsState extends State<AttendanceEvents>
    with SingleTickerProviderStateMixin {
  late AgendaViewModel viewModel = widget.viewModel;
  late TabController _tabController;

  @override
  void initState() {
    viewModel.fetchAttendanceFromSession();
    viewModel.fetchAttended();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AgendaViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<AgendaViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.agendaTitle),
              backgroundColor: MyColorsPalette.red,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.fetchAttendanceFromSession();
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: MyDrawer(
              "Agenda",
              Session(),
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.red.shade800,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.calendar_month),
                          text: AppLocalizations.of(context)!.agendaTitle,
                        ),
                        Tab(
                            icon: Icon(Icons.confirmation_number_outlined),
                            text: AppLocalizations.of(context)!.attendedEvents
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Center(
                            child: viewModel.attendanceList.status ==
                                    Status.LOADING
                                ? const SizedBox(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : viewModel.attendanceList.status ==
                                        Status.ERROR
                                    ? Text(viewModel.attendanceList.toString())
                                    : viewModel.attendanceList.status ==
                                            Status.COMPLETED
                                        ? agendaListSwitch(
                                            assistance:
                                                viewModel.attendanceList.data!)
                                        : const Text("asdfasdf"),
                          ),
                          Center(
                            child: viewModel.attendedList.status ==
                                    Status.LOADING
                                ? const SizedBox(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : viewModel.attendedList.status == Status.ERROR
                                    ? Text(viewModel.attendedList.toString())
                                    : viewModel.attendedList.status ==
                                            Status.COMPLETED
                                        ? agendaListSwitch(
                                            assistance:
                                                viewModel.attendedList.data!)
                                        : const Text("asdfasdf"),
                          )
                        ]),
                  ),
                ],
              ),
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
    return EventInfoTile(event: events[idx], index: idx);
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
