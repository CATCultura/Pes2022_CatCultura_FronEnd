import 'package:flutter/cupertino.dart';

import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import 'HorizontalScrollingRow.dart';

class EventsByTagWidget extends StatelessWidget {

  final String tag;
  final List<EventResult> events;


  const EventsByTagWidget(this.tag, this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0,),
        Text("Perquè t'agrada ${tag}"),
        const SizedBox(height: 8.0,),
        SizedBox(
          height: 200,
          child: HorizontalScrollingRow(events),
        )
      ],
    );

  }
}