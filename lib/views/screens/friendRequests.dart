import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/RequestsUserViewModel.dart';
import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';


class FriendRequests extends StatefulWidget {
  FriendRequests({super.key});
  FriendRequestsState createState() => FriendRequestsState();
}


class FriendRequestsState extends State<FriendRequests> with SingleTickerProviderStateMixin {

  final RequestsUserViewModel viewModel = RequestsUserViewModel();
  late List <String> usersList = [];
  final Session sessio = Session();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    viewModel.receivedUsersById(sessio.data.id.toString());
    viewModel.notifyListeners();
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
    viewModel.receivedUsersById(sessio.data.id.toString());
    viewModel.requestedUsersById(sessio.data.id.toString());
    viewModel.notifyListeners();
    return ChangeNotifierProvider<RequestsUserViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<RequestsUserViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.orangeAccent,
              title: Text(
                  AppLocalizations.of(context)!.friendRequests,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )
              ),
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
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: MyDrawer("Profile",  Session(),),
            body: DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.orangeAccent,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                            icon: Icon(Icons.mark_email_unread),
                            text: AppLocalizations.of(context)!.receivedRequest,),
                        Tab(
                            icon: Icon(Icons.send),
                            text: AppLocalizations.of(context)!.sentRequest,),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: <Widget>[
                        Container(
                          child: viewModel.usersReceived.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
                          viewModel.usersReceived.status == Status.ERROR? Text(viewModel.usersReceived.toString()):
                          viewModel.usersReceived.status == Status.COMPLETED? ListView.builder(
                            itemCount: sessio.data.receivedRequestsIds!.length,
                            shrinkWrap:true,
                            itemBuilder:(BuildContext context, int index) => Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                          Container(
                                            width: 55.0,
                                            height: 55.0,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.orangeAccent,
                                              foregroundColor: Colors.orangeAccent,
                                              backgroundImage: AssetImage('resources/img/logo.png'),
                                            ),
                                          ),
                                          SizedBox(width: 6.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(viewModel.usersReceived.data![index].username!, style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                              SizedBox(height:5.0),
                                              Text(viewModel.usersReceived.data![index].nameAndSurname!, style: TextStyle(color: Colors.grey)),

                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 10.0),
                                        child: IconButton(
                                          iconSize: 40,
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.orangeAccent,
                                          ),
                                          onPressed: () {
                                            viewModel.putFriendById(sessio.data.id.toString(), viewModel.usersReceived.data![index].id!);
                                            var aux = int.parse(viewModel.usersReceived.data![index].id!);
                                            viewModel.usersReceived.data!.remove(aux);
                                            sessio.data.receivedRequestsIds!.remove(aux);
                                            sessio.data.friendsId!.add(aux);
                                            viewModel.notifyListeners();
                                          },
                                        ),
                                      ),
                                      // SizedBox(width: 1.0,),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 10.0),
                                        child: IconButton(
                                          iconSize: 40,
                                          icon: Icon(
                                            Icons.no_accounts,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            viewModel.deleteFriendById(sessio.data.id.toString(), viewModel.usersReceived.data![index].id!);
                                            var aux = int.parse(viewModel.usersReceived.data![index].id!);
                                            viewModel.usersReceived.data!.remove(aux);
                                            sessio.data.receivedRequestsIds!.remove(aux);
                                            viewModel.notifyListeners();
                                          },
                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                              ),
                            ),

                          ):Text("res"),
                        ),
                        Container(
                          child: viewModel.usersRequested.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
                          viewModel.usersRequested.status == Status.ERROR? Text(viewModel.usersRequested.toString()):
                          viewModel.usersRequested.status == Status.COMPLETED? ListView.builder(
                            itemCount: sessio.data.sentRequestsIds!.length,
                            shrinkWrap:true,
                            itemBuilder:(BuildContext context, int index) => Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                          Container(
                                            width: 55.0,
                                            height: 55.0,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.orangeAccent,
                                              foregroundColor: Colors.orangeAccent,
                                              backgroundImage: AssetImage('resources/img/logo.png'),
                                            ),
                                          ),
                                          SizedBox(width: 6.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(viewModel.usersRequested.data![index].username!, style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                              SizedBox(height:5.0),
                                              Text(viewModel.usersRequested.data![index].nameAndSurname!, style: TextStyle(color: Colors.grey)),

                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 10.0),
                                        child: IconButton(
                                          iconSize: 35,
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.orangeAccent,
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/another-user-profile',
                                            arguments: AnotherProfileArgs(viewModel.usersRequested.data![index].username!, viewModel.usersRequested.data![index].id!));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ):Text("res"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })
    );
  }




}