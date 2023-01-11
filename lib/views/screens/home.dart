
import 'package:CatCultura/views/widgets/errorWidget.dart';
import 'package:CatCultura/views/widgets/interestingEventsWidget.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/constants/theme.dart';

import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';

import '../../utils/Session.dart';
import '../../viewModels/HomeViewModel.dart';
import '../widgets/eventsByTagWidget.dart';


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
    viewModel.fetchEventsByTag();
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
              actions: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () => {
                          Navigator.pushNamed(context, '/events')
                        },
                        icon: const Icon(
                            Icons.search,
                            color: Colors.black
                        ),
                    )
                  ],
                ),
              ],
              backgroundColor: Colors.lightGreen,
            ),
            backgroundColor: Colors.white,
            // key: _scaffoldKey,
            drawer: MyDrawer(
                AppLocalizations.of(context)!.homeScreenTitle,  Session(),),
            body: Container(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: ListView(
                // shrinkWrap: true,
                children: [
                  if (session.data.id != -1) Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 25.0,),
                          ElevatedButton.icon(
                            onPressed: () => {
                              Navigator.pushNamed(context, '/favorits')
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.star,
                              color: Colors.lightGreen
                            ),
                            label: Text(AppLocalizations.of(context)!.favouritesTitle,
                              style: TextStyle(
                                color: Colors.lightGreen, fontWeight: FontWeight.w300
                              ),
                            )
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 25.0,),
                          ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(context, '/agenda'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                              icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.lightGreen
                              ),
                              label: Text(AppLocalizations.of(context)!.agendaTitle,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.w300
                                ),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Center(
                    child: Text(AppLocalizations.of(context)!.interestingEventsSection,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.lightGreen
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-100,
                    child: viewModel.eventsList.status == Status.LOADING ?
                      const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator()),
                    )
                        : viewModel.eventsList.status == Status.ERROR
                          ? Column(
                            children: [
                              ElevatedButton(onPressed: () => viewModel.fetchEvents(), child: Text(AppLocalizations.of(context)!.retryButton)),
                              CustomErrorWidget()
                            ],
                          )
                        : viewModel.eventsList.status ==
                          Status.COMPLETED ? InterestingEventsWidget(viewModel.eventsList.data!) : const Text("Error"),
                ),
              if (session.data.id != -1) for(int i = 0; i < tags.length; ++i) viewModel.tagEventList[tags[i]]!.status == Status.LOADING ?
                    const SizedBox(
                      child: Center(
                          child: CircularProgressIndicator()),
                    ) : viewModel.tagEventList[tags[i]]!.status == Status.ERROR ?
                          Column(
                            children: [
                              ElevatedButton(onPressed: () => viewModel.fetchEventsByTagListPosition(i), child: Text(AppLocalizations.of(context)!.retryButton)),
                              CustomErrorWidget()
                            ],
                          )
                  : viewModel.tagEventList[tags[i]]!.status == Status.COMPLETED
                  ? EventsByTagWidget(tags[i], viewModel.tagEventList[tags[i]]!.data!) : const Text("Error"),
                ]
              ),
              ),
            );
    }
    ));
  }



}




