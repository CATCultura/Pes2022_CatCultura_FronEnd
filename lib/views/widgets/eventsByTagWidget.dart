import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import '../../viewModels/InterestingViewModel.dart';
import 'HorizontalScrollingRow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cards/FixedSmallCard.dart';

class EventsByTagWidget extends StatefulWidget {
  EventsByTagWidget(this.tag, this.events, {super.key});
  final List<EventResult> events;
  final String tag;

  final InterestingViewModel viewModel = InterestingViewModel();

  @override
  State<EventsByTagWidget> createState() => _EventsByTagWidget();
}

class _EventsByTagWidget extends State<EventsByTagWidget> {
  late InterestingViewModel viewModel = widget.viewModel;
  late List<EventResult> events = widget.events;
  late String tag = widget.tag;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InterestingViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<InterestingViewModel>(builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "${AppLocalizations.of(context)!.tagEventsSection} $tag",
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 200,
                child: _buildList(events),
              )
            ],
          );
        }));
  }

  Widget _buildList(List<EventResult> event) {
    return Scrollbar(
      child: ListView(
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: buildTagList(events)),
    );
  }

  List<Widget> buildTagList(List<EventResult> list) {
    return [
      for (int i = 0; i < list.length; i += 1)
        wrapWidget(FixedCardSmall(list[i]), i),
    ];
  }

  GestureDetector wrapWidget(Widget w, int index) {
    return GestureDetector(
      onDoubleTap: () {
        if (Session().data.id != -1) {
          viewModel.session.data.favouritesId!
                  .contains(int.parse(events[index].id!))
              ? viewModel.deleteFavouriteById(events[index].id!)
              : viewModel.putFavouriteById(events[index].id!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Stack(alignment: Alignment.topRight, children: [
          w,
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: viewModel.session.data.id != -1
                ? Align(
                    alignment: Alignment.topRight,
                    child: viewModel.session.data.favouritesId!
                            .contains(int.parse(events[index].id!))
                        ? const Icon(Icons.star, color: Colors.red)
                        : const Icon(Icons.star_border_outlined, color: Colors.red))
                : const Align(),
          )
        ]),
      ),
    );
  }
}
