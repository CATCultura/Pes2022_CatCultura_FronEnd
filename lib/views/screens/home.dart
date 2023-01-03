import 'dart:math';

import 'package:CatCultura/views/widgets/interestingEventsWidget.dart';
import 'package:flutter/material.dart';


import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/cards/cardSmall.dart';
import 'package:CatCultura/views/widgets/cards/CardSquare.dart';
import 'package:CatCultura/views/widgets/cards/cardHorizontal.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import '../../viewModels/HomeViewModel.dart';
import '../widgets/eventsByTagWidget.dart';
import '../widgets/horizontalScrollingRow.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:tryproject2/lib/widgets/navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var viewModel = HomeViewModel();
  final Session session = Session();

  @override
  void initState() {
    viewModel.fetchEvents();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    List<String> tags = viewModel.tagEventList.keys.toList();
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HomeViewModel>(builder: (context, value, _)
      {
        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.homeScreenTitle),
              backgroundColor: MyColorsPalette.lightBlue,
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer(
                "Home", username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Container(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: ListView(
                // shrinkWrap: true,
                children: [
                  Text(AppLocalizations.of(context)!.interestingEventsSection),
                  SizedBox(height: 8.0,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-150,
                    child: viewModel.eventsList.status == Status.LOADING ?
                      const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator()),
                    )
                        : viewModel.eventsList.status == Status.ERROR
                          ? Text(viewModel.eventsList.toString())
                        : viewModel.eventsList.status ==
                          Status.COMPLETED ? InterestingEventsWidget(viewModel.eventsList.data!) : Text("Error"),
                ),
              viewModel.tagEventList[tags[0]]!.status == Status.LOADING ?
              const SizedBox(
                child: Center(
                    child: CircularProgressIndicator()),
              )
                  : viewModel.tagEventList[tags[0]]!.status == Status.COMPLETED
                  ? EventsByTagWidget(tags[0], viewModel.tagEventList[tags[0]]!.data!) : Text("Error"),
                  viewModel.tagEventList[tags[1]]!.status == Status.LOADING ?
                  const SizedBox(
                    child: Center(
                        child: CircularProgressIndicator()),
                  )
                      : viewModel.tagEventList[tags[1]]!.status == Status.COMPLETED
                      ? EventsByTagWidget(tags[1], viewModel.tagEventList[tags[1]]!.data!) : Text("Error"),
                  viewModel.tagEventList[tags[2]]!.status == Status.LOADING ?
                  const SizedBox(
                    child: Center(
                        child: CircularProgressIndicator()),
                  )
                      : viewModel.tagEventList[tags[2]]!.status == Status.COMPLETED
                      ? EventsByTagWidget(tags[2], viewModel.tagEventList[tags[2]]!.data!) : Text("Error"),
                ]
              ),
              ),
            );
    }
    ));
  }



}




