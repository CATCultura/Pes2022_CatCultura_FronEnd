import 'package:CatCultura/views/widgets/events/eventContainerAgenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/FavoritsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../utils/Session.dart';
import '../widgets/events/eventInfoTile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Favorits extends StatefulWidget {
  Favorits({super.key});

  final FavoritsViewModel viewModel = FavoritsViewModel();
  @override
  State<Favorits> createState() => _Favorits();
}

class _Favorits extends State<Favorits> {
  late FavoritsViewModel viewModel = widget.viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.fetchFavouritesFromSession();
    return ChangeNotifierProvider<FavoritsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<FavoritsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Favorits"),
              backgroundColor: Colors.redAccent,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.fetchFavouritesFromSession();
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            // key: _scaffoldKey,
            drawer: MyDrawer(
              "Favorits",
              Session(),
            ),
            body: Center(
              child: viewModel.favouritesList.status == Status.LOADING
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : viewModel.favouritesList.status == Status.ERROR
                      ? Text(viewModel.favouritesList.toString())
                      : viewModel.favouritesList.status == Status.COMPLETED
                          ? buildList(viewModel.favouritesList.data!)
                          : const Text("asdfasdf"),
            ),
          );
        }));
  }

  Widget buildList(List<EventResult> events) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildEventShort(events[i], i);
        });
  }

  Widget _buildEventShort(EventResult event, int idx) {
    return Dismissible(
      key: Key(event.id!),
      child: EventInfoTile(event: event, index: idx),
      onDismissed: (direction) => {
        viewModel.deleteFavouriteById(event.id!),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                viewModel.addFavouriteById(event.id!);
              },
            ),
            content: Text("Tret de favorits.")))
      },
    );
  }
}

// class favoritsListSwitch extends StatefulWidget {
//   final List<EventResult> events;
//
//   const favoritsListSwitch({super.key, required this.events});
//   @override
//   State<favoritsListSwitch> createState() => favoritsListSwitchState();
// }
//
// class favoritsListSwitchState extends State<favoritsListSwitch> {
//   late List<EventResult> events = widget.events;
//
//   Widget _buildEventShort(int idx) {
//     return EventInfoTile(event: events[idx], index: idx);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: events.length,
//         itemBuilder: (BuildContext context, int i) {
//           return _buildEventShort(i);
//         });
//   }
// }
