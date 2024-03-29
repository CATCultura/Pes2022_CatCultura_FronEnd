import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/viewModels/BlocksViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/myDrawer.dart';

class Blocks extends StatefulWidget {
  Blocks({super.key});
  BlocksState createState() => BlocksState();
}

class BlocksState extends State<Blocks> with SingleTickerProviderStateMixin {
  final BlocksViewModel viewModel = BlocksViewModel();
  late TabController _tabController;

  @override
  void initState() {
    viewModel.fetchReviewsReports();
    viewModel.fetchUsersReports();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          debugPrint("lista 1 !!!!!!!!!!!");
          break;
        case 1:
          debugPrint("lista 2 !!!!!!!!!!!");
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlocksViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<BlocksViewModel>(builder: (context, value, _) {
          return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.blocksMainTitle),
              ),
              drawer: MyDrawer(
                "Blocks",
                Session(),
              ),
              body: DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                                icon: Icon(Icons.reviews),
                                text: AppLocalizations.of(context)!
                                    .reportedReviewsTitle),
                            Tab(
                                icon: Icon(Icons.person),
                                text: AppLocalizations.of(context)!
                                    .reportedUsersTitle),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: <Widget>[
                            Center(
                              child: viewModel.reviewsList.status ==
                                      Status.LOADING
                                  ? const CircularProgressIndicator()
                                  : viewModel.reviewsList.data!.length > 0 ? ListView.builder(
                                      itemCount:
                                          viewModel.reviewsList.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/another-user-profile',
                                                            arguments: AnotherProfileArgs(
                                                                viewModel
                                                                    .reviewsList
                                                                    .data![
                                                                        index]
                                                                    .author!,
                                                                viewModel
                                                                    .reviewsList
                                                                    .data![
                                                                        index]
                                                                    .userId!
                                                                    .toString()));
                                                      },
                                                      child: Text(
                                                        viewModel
                                                            .reviewsList
                                                            .data![index]
                                                            .author!,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )),
                                                  Text(viewModel.reviewsList
                                                      .data![index].date!),
                                                ],
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, '/reviewUnica',
                                                        arguments: ReviewUnicaArgs(
                                                            viewModel
                                                                .reviewsList
                                                                .data![index]));
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 6.0,
                                                                bottom: 8.0),
                                                        child: Text(
                                                          viewModel
                                                              .reviewsList
                                                              .data![index]
                                                              .title!,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(viewModel
                                                              .reviewsList
                                                              .data![index]
                                                              .review!)),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .red
                                                                    .shade800),
                                                        onPressed: () {
                                                          viewModel.blockReview(
                                                              viewModel
                                                                  .reviewsList
                                                                  .data![index]
                                                                  .reviewId!);
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .blockButton)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .green
                                                                    .shade800),
                                                        onPressed: () {
                                                          viewModel.unblockReview(
                                                              viewModel
                                                                  .reviewsList
                                                                  .data![index]
                                                                  .reviewId!);
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .unblockButton)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // leading: Row(children: [
                                            //   ElevatedButton(style: ElevatedButton.styleFrom(
                                            //     primary: Colors.purple),onPressed: (){}, child: Text("Bloquear"))
                                            // ],),
                                          ),
                                        );
                                      })
                             : Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text("😊", style: TextStyle(fontSize: 50),),
                                    const SizedBox(height: 10,),
                                    Text(AppLocalizations.of(context)!.noReviewsToBlock, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,)),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: viewModel.usersList.status ==
                                      Status.LOADING
                                  ? const CircularProgressIndicator()
                                  : viewModel.usersList.data!.length > 0 ?ListView.builder(
                                      itemCount:
                                          viewModel.usersList.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/another-user-profile',
                                                            arguments: AnotherProfileArgs(
                                                                viewModel
                                                                    .usersList
                                                                    .data![
                                                                        index]
                                                                    .username!,
                                                                viewModel
                                                                    .usersList
                                                                    .data![
                                                                        index]
                                                                    .id!
                                                                    .toString()));
                                                      },
                                                      child: Text(
                                                        viewModel
                                                            .usersList
                                                            .data![index]
                                                            .username!,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .red
                                                                    .shade800),
                                                        onPressed: () {
                                                          viewModel.blockUser(
                                                              viewModel
                                                                  .usersList
                                                                  .data![index]
                                                                  .id!);
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .blockButton)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .green
                                                                    .shade800),
                                                        onPressed: () {
                                                          viewModel.unblockUser(
                                                            viewModel
                                                                .usersList
                                                                .data![index]
                                                                .id!,
                                                          );
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .unblockButton)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // leading: Row(children: [
                                            //   ElevatedButton(style: ElevatedButton.styleFrom(
                                            //     primary: Colors.purple),onPressed: (){}, child: Text("Bloquear"))
                                            // ],),
                                          ),
                                        );
                                      })
                              : Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text("😊", style: TextStyle(fontSize: 50),),
                                    const SizedBox(height: 10,),
                                    Text(AppLocalizations.of(context)!.noUsersToBlock, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
        }));
  }
}
