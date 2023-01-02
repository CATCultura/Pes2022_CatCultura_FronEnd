import 'dart:math';

import 'package:flutter/material.dart';


import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/cards/cardSmall.dart';
import 'package:CatCultura/views/widgets/cards/CardSquare.dart';
import 'package:CatCultura/views/widgets/cards/cardHorizontal.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import '../../viewModels/HomeViewModel.dart';

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
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HomeViewModel>(builder: (context, value, _)
      {
        return Scaffold(
            appBar: AppBar(
              title: Text("HOME"),
              backgroundColor: MyColorsPalette.lightBlue,
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer(
                "Home", username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: viewModel.eventsList.status ==
                          Status.LOADING
                          ? const SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()),
                      )
                          : viewModel.eventsList.status == Status.ERROR
                          ? Text(viewModel.eventsList.toString())
                          : viewModel.eventsList.status ==
                          Status.COMPLETED
                          ?
                      CardSquare(viewModel.eventsList.data![0]) : const Text(
                          "oopsie"),
                    ),
                    const SizedBox(height: 8.0),
                    buildHorizontal(1),
                    const SizedBox(height: 8.0),
                    buildHorizontal(2),
                    const SizedBox(height: 8.0),
                    buildHorizontal(3),
                    const SizedBox(height: 8.0),
                    buildHorizontal(4),
                    const SizedBox(height: 8.0),
                    buildHorizontal(5),
                    const SizedBox(height: 8.0),
                    buildTwoSmalls(6, 7),
                    buildTwoSmalls(8, 9),
                    const SizedBox(height: 8.0),

                  ],
                ),
              ),
            ));
    }
    ));
  }
  Padding buildHorizontal(int index) {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child:viewModel.eventsList.status ==
            Status.LOADING
            ? const SizedBox(
          child: Center(
              child: CircularProgressIndicator()),
        )
            : viewModel.eventsList.status == Status.ERROR
            ? Text(viewModel.eventsList.toString())
            : viewModel.eventsList.status ==
            Status.COMPLETED
            ?
        CardHorizontal(viewModel.eventsList.data![index])
            : const Text("oopsie")
    );
  }

  Row buildTwoSmalls(int index1, int index2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        viewModel.eventsList.status ==
            Status.LOADING
            ? const SizedBox(
          child: Center(
              child: CircularProgressIndicator()),
        )
            : viewModel.eventsList.status == Status.ERROR
            ? Text(viewModel.eventsList.toString())
            : viewModel.eventsList.status ==
            Status.COMPLETED
            ?
        CardSmall(viewModel.eventsList.data![index1])
            : const Text("oopsie"),
        viewModel.eventsList.status ==
            Status.LOADING
            ? const SizedBox(
          child: Center(
              child: CircularProgressIndicator()),
        )
            : viewModel.eventsList.status == Status.ERROR
            ? Text(viewModel.eventsList.toString())
            : viewModel.eventsList.status ==
            Status.COMPLETED
            ?
        CardSmall(viewModel.eventsList.data![index2])
            : const Text("oopsie")
      ],
    );
  }



}

ListView buildTiles(List<EventResult> eventList, int offset, int number) {
  var _scrollController = ScrollController();

  List<EventResult> toShow = eventList.getRange(offset, offset+number).toList();


  return ListView.builder(
      itemCount: toShow.length,
      controller:
      _scrollController,
      itemBuilder:
          (BuildContext context,
          int i) {
        return CardHorizontal(
          eventList[i]
        );
      });
}


