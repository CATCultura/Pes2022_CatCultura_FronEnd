import 'package:flutter/material.dart';

import '../../models/EventResult.dart';
import 'cards/FixedSmallCard.dart';

class HorizontalScrollingRow extends StatelessWidget {
  final List<EventResult> events;


  const HorizontalScrollingRow(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: buildTagList(events)
      ),
    );

  }

  List<Widget> buildTagList(List<EventResult> list) {
    return [
      for (int i = 0; i < 20; i+=1) FixedCardSmall(list[i]),
    ];
  }

}