import 'dart:math';

import 'package:CatCultura/views/widgets/cards/cardSmall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import '../../viewModels/InterestingViewModel.dart';
import 'cards/CardSquare.dart';
import 'cards/cardHorizontal.dart';

class InterestingEventsWidget extends StatefulWidget {
  InterestingEventsWidget(this.events, {super.key});
  final List<EventResult> events;

  final InterestingViewModel viewModel = InterestingViewModel();
  @override
  State<InterestingEventsWidget> createState() => _InterestingEventsWidget();
}

class _InterestingEventsWidget extends State<InterestingEventsWidget> {
  late InterestingViewModel viewModel = widget.viewModel;
  late List<EventResult> events = widget.events;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InterestingViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<InterestingViewModel>(builder: (context, value, _) {
        return ListView(
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: buildList(),
        );
      }),
    );
  }

  GestureDetector wrapWidget(Widget w, int index) {
    return GestureDetector(
      onDoubleTap: () {
        if (Session().data.id != -1) {
          viewModel.session.data.favouritesId!.contains(int.parse(events[index].id!))
            ? viewModel.deleteFavouriteById(events[index].id!)
            : viewModel.putFavouriteById(events[index].id!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Stack(children: [
          w,
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: viewModel.session.data.id != -1 ? Align(
                alignment: Alignment.bottomRight,
                child: viewModel.session.data.favouritesId!.contains(int.parse(events[index].id!))
                    ? Icon(Icons.star, color: Colors.red)
                    : Icon(Icons.star_border_outlined, color: Colors.red)) : Align(),
          )
        ]),
      ),
    );
  }

  Padding buildSquared(int index) {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: CardSquare(events[index]));

  }

  Padding buildHorizontal(int index) {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: CardHorizontal(events[index]));
  }

  Widget buildTwoSmalls(int index1, int index2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        wrapWidget(SizedBox(width: MediaQuery.of(context).size.width/2-20, child: CardSmall(events[index1])), index1),
        if (index1 != index2) SizedBox(width: MediaQuery.of(context).size.width/2 -20,child: wrapWidget(CardSmall(events[index2]), index2))
      ],
    );
  }

  List<Widget> buildList() {
    return [
      if (events.isNotEmpty) wrapWidget(buildSquared(0),0),
      const SizedBox(height: 8.0),
      if (events.length > 1) wrapWidget(buildSquared(1),1),
      const SizedBox(height: 8.0),
      if (events.length > 2)
        for (int i = 2; i < min(9, events.length); ++i) wrapWidget(buildHorizontal(i),i),
      const SizedBox(height: 8.0),
      if (events.length > 10)
        for (int j = 9; j < events.length; j += 2)
          buildTwoSmalls(j, min(j + 1, events.length - 1)),
      const SizedBox(height: 8.0),
      const SizedBox(height: 8.0),
    ];
  }
}
