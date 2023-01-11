

import 'package:CatCultura/views/widgets/errorWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../viewModels/OrganizerEventsViewModel.dart';
import '../../viewModels/TagEventsViewModel.dart';
import '../widgets/events/eventInfoTile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/myDrawer.dart';

class TagEvents extends StatefulWidget {
  TagEvents(this.tagName, {super.key});

  final String tagName;
  final TagEventsViewModel viewModel = TagEventsViewModel();

  @override
  State<TagEvents> createState() => _TagEvents();
}

class _TagEvents extends State<TagEvents> {

  late TagEventsViewModel viewModel = widget.viewModel;
  late String tagName = widget.tagName;


  @override
  void initState() {
    super.initState();
    viewModel.fetchEvents(tagName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TagEventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<TagEventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text("${AppLocalizations.of(context)!.tagEventsScreenTitle} $tagName")
                    ]
                ),
              )
              ,
            ),
            backgroundColor: Colors.white,
            drawer: MyDrawer("tag",Session()),
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