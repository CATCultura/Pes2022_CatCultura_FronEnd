import 'package:CatCultura/views/widgets/events/eventContainerAgenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/FavoritsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../widgets/events/eventInfoTile.dart';

class Favorits extends StatelessWidget {
  Favorits({super.key});
  final FavoritsViewModel viewModel = FavoritsViewModel();

  @override
  Widget build(BuildContext context) {
    String loggedUserId = viewModel.passwordSessio();
    viewModel.fetchFavouritesById(loggedUserId);
    return ChangeNotifierProvider<FavoritsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<FavoritsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Favorits"),
              backgroundColor: MyColorsPalette.red,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.fetchFavouritesById(loggedUserId);
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Favorits",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.favouritesList.status == Status.LOADING? const SizedBox(
                child: Center(child: CircularProgressIndicator()),
              ):
              viewModel.favouritesList.status == Status.ERROR? Text(viewModel.favouritesList.toString()):
              viewModel.favouritesList.status == Status.COMPLETED? favoritsListSwitch(events: viewModel.favouritesList.data!) : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class favoritsListSwitch extends StatefulWidget {
  final List<EventResult> events;

  const favoritsListSwitch({super.key, required this.events});
  @override
  State<favoritsListSwitch> createState() => favoritsListSwitchState();
}

class favoritsListSwitchState extends State<favoritsListSwitch> {
  late List<EventResult> events = widget.events;

  Widget _buildEventShort(int idx) {
    return EventInfoTile(event: events[idx], index: idx);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildEventShort(i);
        });

  }
}
