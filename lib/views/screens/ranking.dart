import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/RankingViewModel.dart';
import '../../data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import '../../utils/Session.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulRanking(),
    );
  }
}

class StatefulRanking extends StatefulWidget {
  const StatefulRanking({Key? key}) : super(key: key);

  @override
  State<StatefulRanking> createState() => _StatefulRankingState();
}

class _StatefulRankingState extends State<StatefulRanking>  {
  final Session sessio = Session();
  final RankingViewModel viewModel = RankingViewModel();
  var index = 1;
  late int i;
  //final List<UserResult> friends = [];
  //friendsList.sort((a, b) => a.);

  @override
  void initState() {
    viewModel.iniRanking();
  }

  @override
  Widget build(BuildContext context) {
      //viewModel.iniRanking();
      return ChangeNotifierProvider<RankingViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<RankingViewModel>(builder: (context, value, _)
          {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                backgroundColor: Colors.orangeAccent,
                title: Text(
                    AppLocalizations.of(context)!.ranking,
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
              backgroundColor: Colors.white,
              // key: _scaffoldKey,
              drawer: MyDrawer("Profile", Session()),
              body: Container(
                  child: viewModel.finish? ListView.builder(
                  itemCount: viewModel.users.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, index) =>
                    GestureDetector(
                      onTap: () {
                        sessio.data.id.toString() == viewModel.users[index].id! ? Text(""):
                        Navigator.pushNamed(context, '/another-user-profile', arguments: AnotherProfileArgs(viewModel.users[index].username!, viewModel.users[index].id!));
                      },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                              Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              index == 0 ? const SizedBox(
                                                width: 55.0,
                                                height: 55.0,

                                                 child: CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                   backgroundImage: AssetImage('resources/img/tofeu1.png'),
                                                   //backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.es%2Ffotos-vectores-gratis%2Ftrofeo-oro&psig=AOvVaw2fw1Ta9S_-aru_NlT0Szm3&ust=1673180857051000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCPie78i6tfwCFQAAAAAdAAAAABAD'),
                                                 ),
                                              ): index == 1 ? const SizedBox(
                                                width: 55.0,
                                                height: 55.0,

                                                child: CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.green,
                                                  backgroundImage: AssetImage('resources/img/tofeu2.png'),
                                                  //backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.123rf.com%2Fphoto_91752771_ilustraci%25C3%25B3n-del-icono-de-la-taza-del-trofeo-plata-x28-2do-lugar-x29-.html&psig=AOvVaw2tMgrUNRaL9HjDeUMHZ8Oa&ust=1673180943630000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCODr-pC7tfwCFQAAAAAdAAAAABAD'),
                                                ),
                                              ):
                                              index == 2 ? const SizedBox(
                                                width: 55.0,
                                                height: 55.0,

                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.white,
                                                  backgroundImage: AssetImage('resources/img/tofeu3.png'),
                                                  //backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.pngtree.com%2Ffreepng%2Fbronze-trophy_22561.html&psig=AOvVaw19ztsmi9hTQgaIlQMK5ZWu&ust=1673181133276000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCPj2lsu7tfwCFQAAAAAdAAAAABAD'),
                                                ),
                                              ):
                                              const SizedBox(
                                                width: 55.0,
                                                height: 55.0,

                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.white,
                                                  backgroundImage: AssetImage('resources/img/logo.png'),
                                                ),
                                              ),
                                              const SizedBox(width: 6.0,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  FittedBox(
                                                    child: Text(

                                                      '${viewModel.users[index].username!
                                                          .toString()}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold),),),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                      '${AppLocalizations.of(context)!.points}: ${viewModel.users[index].points!
                                                          .toString()}',
                                                      style: TextStyle(
                                                          color: Colors.green)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                        ),
                    ),
                  ),
                ): const SizedBox(child: Center(child: CircularProgressIndicator()),),

              ),
            );
          }
        )
      );

  }

}

