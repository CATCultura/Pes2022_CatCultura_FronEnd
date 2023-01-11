

import 'package:CatCultura/views/widgets/errorWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../viewModels/OrganizerEventsViewModel.dart';
import '../widgets/events/eventInfoTile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/myDrawer.dart';

class OrganizerEvents extends StatefulWidget {
  OrganizerEvents(this.organizerId, {super.key, this.organizerName = "Anonymous organizer"});
  final int organizerId;
  final String organizerName;
  final OrganizerEventsViewModel viewModel = OrganizerEventsViewModel();

  @override
  State<OrganizerEvents> createState() => _OrganizerEventsState();
}

class _OrganizerEventsState extends State<OrganizerEvents> {
  late int organizerId = widget.organizerId;
  late OrganizerEventsViewModel viewModel = widget.viewModel;
  late String organizerName = widget.organizerName;


  @override
  void initState() {
    super.initState();
    viewModel.fetchEvents(organizerId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrganizerEventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<OrganizerEventsViewModel>(builder: (context, value, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title:
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text("${AppLocalizations.of(context)!.orgEventsScreenTitle} $organizerName")
                    ]
                  ),
                )
                ,
              ),
              backgroundColor: Colors.white,
              drawer: MyDrawer("organizer",Session()),
              body: viewModel.eventsList.status == Status.LOADING ? const SizedBox(
                child: Center(
                    child: CircularProgressIndicator()
                ),
              )
                  : viewModel.eventsList.status == Status.ERROR ? Text(viewModel.eventsList.toString())
                  : viewModel.eventsList.status == Status.COMPLETED ?
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: viewModel
                            .eventsList
                            .data!
                            .length,
                        itemBuilder:
                            (BuildContext context,
                            int i) {
                          return EventInfoTile(
                            event: viewModel
                                .eventsList
                                .data![i],
                            index: i,
                          );
                        }),
                  )
                ],
              ) : const CustomErrorWidget(),
            );
              viewModel.eventsList.status == Status.LOADING ? const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                )
                : viewModel.eventsList.status == Status.ERROR ? Text(viewModel.eventsList.toString())
                : viewModel.eventsList.status == Status.COMPLETED ?
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: viewModel
                          .eventsList
                          .data!
                          .length,
                          itemBuilder:
                          (BuildContext context,
                          int i) {
                            return EventInfoTile(
                            event: viewModel
                              .eventsList
                              .data![i],
                            index: i,
                        );
                      }),
                )
              ],
            ) : const CustomErrorWidget();
        },
        )
    );
  }
}