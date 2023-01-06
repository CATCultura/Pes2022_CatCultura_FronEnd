import 'dart:math';

import 'package:CatCultura/views/widgets/cards/cardSmall.dart';
import 'package:flutter/material.dart';

import '../../models/EventResult.dart';
import 'cards/CardSquare.dart';
import 'cards/cardHorizontal.dart';

class InterestingEventsWidget extends StatelessWidget {

  final List<EventResult> events;


  const InterestingEventsWidget(this.events, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        // shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: buildList(),
      ),
    );
  }



  Padding buildSquared(int index) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: CardSquare(events[index]),
    );
  }


  Padding buildHorizontal(int index) {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: CardHorizontal(events[index])
    );
  }

  Row buildTwoSmalls(int index1, int index2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardSmall(events[index1]),
        if (index1 != index2)
          CardSmall(events[index2])
      ],
    );
  }

  List<Widget> buildList() {
    return [
        if (events.isNotEmpty)
          buildSquared(0),
        const SizedBox(height: 8.0),
        if (events.length > 1)
          buildSquared(1),
        const SizedBox(height: 8.0),
        if (events.length > 2) for (int i = 2; i < min(9, events.length); ++i) buildHorizontal(i), const SizedBox(height: 8.0),
        if (events.length > 10) for (int j = 9; j < events.length; j+=2) buildTwoSmalls(j,min(j+1,events.length-1)), const SizedBox(height: 8.0),
        const SizedBox(height: 8.0),
      ];
    }


}