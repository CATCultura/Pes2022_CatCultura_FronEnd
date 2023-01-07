import 'package:flutter/cupertino.dart';

import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import 'HorizontalScrollingRow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsByTagWidget extends StatelessWidget {

  final String tag;
  final List<EventResult> events;


  const EventsByTagWidget(this.tag, this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0,),
        Text("${AppLocalizations.of(context)!.tagEventsSection} $tag", textAlign: TextAlign.left,),
        const SizedBox(height: 8.0,),
        SizedBox(
          height: 200,
          child: HorizontalScrollingRow(events),
        )
      ],
    );

  }
}