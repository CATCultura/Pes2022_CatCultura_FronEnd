import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../widgets/events/eventInfoTile.dart';

/*class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}

class HomePage extends State<MainPage>{
 //Your code here
}*/

class Events extends StatefulWidget {
  Events({super.key});
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> {
  final EventsViewModel viewModel = EventsViewModel();
  late ScrollController _scrollController;
  bool findedSomething = false;
  String message = "Search by name...";
  var searchResult;

  _scrollListener() {
    // if(_scrollController.offset >= _scrollController.position.maxScrollExtent){
    //   setState(() {
    //     message = "reach the middle";
    //   });
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // setState(() {
      //   message = "reach the end";
      // });
      setState(() {
        viewModel.addNewPage();
      });
      setState(() {});
    }
  }

  void iniState() {
    //debugPrint("inistate!!!!!!!!!!!!!!");
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    viewModel.fetchEvents();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    //});
    //viewModel.fetchEventsListApi();
    //viewModel.save10Suggestions();
  }

  @override
  Widget build(BuildContext context) {
    iniState();
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red.shade900,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              height: AppBar().preferredSize.height / 2,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 5, bottom: 5, right: 5),
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(105, 105, 105, 0.6),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                          )
                          // Container(
                          //   width: double.infinity,
                          //   color: Colors.blue,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(color: Colors.blue,),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    final searchQueryResult = await showSearch(
                      context: context,
                      delegate: SearchEvents(
                        suggestedEvents: viewModel.suggestions,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    if (viewModel.suggestions.contains(searchQueryResult)) {
                      debugPrint(searchQueryResult);
                      Navigator.pushNamed(context, '/eventUnic',
                          arguments: EventUnicArgs(searchQueryResult!));
                    } else if (searchQueryResult != null && searchQueryResult != '') {
                      message = searchQueryResult;
                      findedSomething = true;
                      debugPrint(searchQueryResult);
                      viewModel.setLoading();
                      viewModel.redrawWithFilter(searchQueryResult);
                      //Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(finalResult!));
                    }
                  }),
              backgroundColor: MyColorsPalette.red,
              actions: [
                findedSomething == true
                    ? IconButton(
                        onPressed: () {
                          setState((){message = "Search by name...";
                          findedSomething = false;});
                        },
                        icon: const Icon(Icons.close),
                      )
                    : const SizedBox.shrink(),
                IconButton(
                  onPressed: () {
                    viewModel.refresh();
                    viewModel.fetchEvents();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Events",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Center(
              child: viewModel.eventsList.status == Status.LOADING
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : viewModel.eventsList.status == Status.ERROR
                      ? Text(viewModel.eventsList.toString())
                      : viewModel.eventsList.status == Status.COMPLETED
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      itemCount:
                                          viewModel.eventsList.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return EventInfoTile(
                                          event: viewModel.eventsList.data![i],
                                          index: i,
                                        );
                                      }),
                                ),
                                viewModel.chargingNextPage
                                    ? const SizedBox(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )
                          : const Text("asdfasdf"),
            ),
          );
        }));
  }
}

class SearchEvents extends SearchDelegate<String> {
  final List<String> suggestedEvents;

  SearchEvents({required this.suggestedEvents});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        query = '';
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> usersSuggList = suggestedEvents
        .where(
          (userSugg) => userSugg.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: usersSuggList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(usersSuggList[index]),
        onTap: () {
          query = usersSuggList[index];
          close(context, query);
        },
      ),
    );
  }
}
