import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/RankingViewModel.dart';
import '../../data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import '../../utils/Session.dart';


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
                toolbarHeight: 70,
                title: const Text("Ranking"),
                backgroundColor: MyColorsPalette.lightBlue,
              ),
              backgroundColor: MyColors.bgColorScreen,
              // key: _scaffoldKey,
              drawer: MyDrawer("Ranking Friends",
                  username: "Superjuane", email: "juaneolivan@gmail.com"),
              body: Container(
                child: viewModel.finish? ListView.builder(
                  itemCount: viewModel.users.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, index) =>
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
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
                                      const SizedBox(
                                        width: 55.0,
                                        height: 55.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.green,
                                          backgroundImage: NetworkImage(
                                              'https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
                                        ),
                                      ),
                                      const SizedBox(width: 6.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          FittedBox(
                                            child: Text(
                                              '$index. ${viewModel.users[index].username!
                                                  .toString()}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),),),
                                          const SizedBox(height: 5.0),
                                          Text(
                                              'Punts: ${viewModel.users[index].points!
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
                      ),

                ): const SizedBox(child: Center(child: CircularProgressIndicator()),),
              ),
            );
          }
        )
      );

  }

}

