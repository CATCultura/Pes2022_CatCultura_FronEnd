import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/AllUsersViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../models/Place.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllUsers extends StatefulWidget {
  AllUsers({super.key});
  AllUsersState createState() => AllUsersState();
}

class AllUsersState extends State<AllUsers> with SingleTickerProviderStateMixin {
  final AllUsersViewModel viewModel = AllUsersViewModel();
  late ScrollController _scrollController;
  //late TabController _tabController;
  bool findedSomething = false;
  String message = "";
  var searchResult;
  final Session sessio = Session();
  //late ClusterManager _manager;
  //Completer<GoogleMapController> _controller = Completer();
  //Set<Marker> markers = Set();
  //final CameraPosition _iniCameraPosition =
  //const CameraPosition(target: LatLng(41.3874, 2.1686), zoom: 11.0);

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        viewModel.addNewPage();
        //_manager.setItems(viewModel.eventsListMap.data!);
      });
    }
  }

  @override
  void initState() {
    viewModel.fetchUsers();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    //_manager = _initClusterManager();
    //_tabController = TabController(length: 2, vsync: this);
    //_tabController.addListener(_handleTabSelection);
    //message = AppLocalizations.of(context)!.searchName;
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
      message = AppLocalizations.of(context)!.searchName;
      return ChangeNotifierProvider<AllUsersViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<AllUsersViewModel>(builder: (context, value, _) {
            return Scaffold(
              appBar: AppBar(
                title: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
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
                                      style: TextStyle(
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
                        delegate: SearchUsers(
                          suggestedUsers: viewModel.suggestions,
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      if (viewModel.suggestions.contains(searchQueryResult)) {
                        debugPrint(searchQueryResult);
                        Navigator.pushNamed(context, '/another-user-profile',
                            arguments: EventUnicArgs(searchQueryResult!));
                      }
                      else if (searchQueryResult != null && searchQueryResult != '') {
                        message = searchQueryResult;
                        findedSomething = true;
                        debugPrint(searchQueryResult);
                        viewModel.setLoading();
                        viewModel.redrawWithFilter(searchQueryResult);
                      }
                    }),
                backgroundColor: Colors.orangeAccent,
                actions: [
                  findedSomething == true
                      ? IconButton(
                    onPressed: () {
                      setState(() {
                        message = AppLocalizations.of(context)!.searchName;
                        findedSomething = false;
                      });
                      viewModel.refresh();
                      viewModel.fetchUsers();
                    },
                    icon: const Icon(Icons.close),
                  )
                      : const SizedBox.shrink(),
                  IconButton(
                    onPressed: () {
                      viewModel.refresh();
                      viewModel.fetchUsers();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/profile');
                  },
                ),
              ),
              backgroundColor: Colors.white,
              // key: _scaffoldKey,
              drawer: MyDrawer("Usuaris", Session(),),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[     //no expanded
                     Expanded(
                       child: Center(
                        child: viewModel.usersList.status == Status.LOADING? const SizedBox(
                                child: Center(
                                child: CircularProgressIndicator()),
                        )
                            : viewModel.usersList.status == Status.ERROR? Text(viewModel.usersList.toString())
                            : viewModel.usersList.status == Status.COMPLETED?
                            Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller:
                                      _scrollController,
                                      itemCount: viewModel.usersList.data!.length,
                                      itemBuilder: (BuildContext context,int i) =>
                                        Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                          child: Material(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                //debugPrint("clicked event: ${event.denominacio}");
                                                if (viewModel.usersList.data![i].id!.toString() != sessio.data.id.toString())Navigator.pushNamed(context, '/another-user-profile',
                                                arguments: AnotherProfileArgs(viewModel.usersList.data![i].username!.toString(), viewModel.usersList.data![i].id!.toString()));
                                              },
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Colors.black26, width: 1),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                                tileColor: Theme.of(context).cardColor,
                                                title:
                                                Column(
                                                  children: [
                                                    Text(viewModel.usersList.data![i].username!,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w300, fontSize: 15)),
                                                    const Padding(
                                                      padding: EdgeInsets.only(top: 5),
                                                    ),
                                                ],
                                              ),

                                        ),
                                        /*return UserInfoTile(event: viewModel.usersList.data![i],
                                          index: i,
                                        );
                                        */
                                      ),
                                    ),
                                  ),
                                ),
                                viewModel.chargingNextPage? const SizedBox(
                                  child: Center(
                                      child:
                                      CircularProgressIndicator()),
                                  ): const SizedBox.shrink(),
                              ],

                            ): const Text("a"),
                    ),
                     ),
                  ],
                ),
              ),

            );
          },
        )
      );
    }


}


class SearchUsers extends SearchDelegate<String> {
  final List<String> suggestedUsers;

  SearchUsers({required this.suggestedUsers});

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

    return ListTile(
      title: Text(query),
      onTap: () {
      close(context, query);
    }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> usersSuggList = suggestedUsers
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