import 'dart:ui';

import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../viewModels/SavedRutesCulturalsViewModel.dart';
import '../widgets/events/eventInfoTile.dart';

class SavedRutesCulturals extends StatefulWidget {
  const SavedRutesCulturals({super.key});

  @override
  SavedRutesCulturalsState createState() => SavedRutesCulturalsState();
}

class SavedRutesCulturalsState extends State<SavedRutesCulturals> {
  SavedRutesCulturalsViewModel viewModel = SavedRutesCulturalsViewModel();

  @override
  void initState() {
    viewModel.getSavedRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedRutesCulturalsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<SavedRutesCulturalsViewModel>(
            builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.lightBlue),
            ),
            body: Center(
              child: viewModel.routeList.status == Status.LOADING
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : viewModel.routeList.status == Status.ERROR
                      ? Text(viewModel.routeList.toString())
                      : viewModel.routeList.status == Status.COMPLETED
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      // controller:
                                      // _scrollController,
                                      itemCount:
                                          viewModel.routeList.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return ListTile(
                                            title: Text(viewModel.routeList.data![i].name!),
                                            onTap: (){
                                              Navigator.pop(context, RutaCulturalLoadArgs(viewModel.routeList.data![i].events));
                                            },
                                        );
                                        //   EventInfoTile(
                                        //   event: viewModel.routeList.data![i],
                                        //   index: i,
                                        // );
                                      }),
                                ),
                              ],
                            )
                          : const Text("asdfasdf"),
            ),
          );
        }));
  }
}
