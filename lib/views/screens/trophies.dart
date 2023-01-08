import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/TrophyViewModel.dart';
import '../../data/response/apiResponse.dart';
import 'package:CatCultura/models/SessionResult.dart';

import '../../utils/Session.dart';


class Trophies extends StatelessWidget {
  final Session sessio = Session();
  final TrophyViewModel viewModel = TrophyViewModel();
  late List <String> trophyList = [];
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    viewModel.receivedTrophies();
    /*
    for (int i = 0; i < sessio.data.trophiesId!.length; i++ ){
      if (viewModel.trophies.data!.toString().contains(sessio.data.trophiesId![i].toString())){
        trophyList[i] = sessio.data.trophiesId![i].toString();
      }
    }
     */

    return ChangeNotifierProvider<TrophyViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<TrophyViewModel>(builder: (context, value, _)
    {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text("Trofeus"),
          backgroundColor: MyColorsPalette.lightBlue,
        ),
        backgroundColor: MyColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: MyDrawer("Profile", Session(),),
        body: Container(
          child: viewModel.trophies.status == Status.LOADING ? const SizedBox(child: Center(child: CircularProgressIndicator()),) :
          viewModel.trophies.status == Status.ERROR ? Text(viewModel.trophies.toString()) :
          viewModel.trophies.status == Status.COMPLETED ? ListView.builder(
            itemCount: viewModel.trophies.data!.length,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, int index) =>
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.symmetric(
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
                      padding: EdgeInsets.symmetric(
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
                                Container(
                                  width: 55.0,
                                  height: 55.0,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.green,
                                    backgroundImage: NetworkImage(
                                        'https://media.istockphoto.com/id/1168757141/vector/gold-trophy-with-the-name-plate-of-the-winner-of-the-competition.jpg?s=612x612&w=0&k=20&c=ljsP4p0yuJnh4f5jE2VwXfjs96CC0x4zj8CHUoMo39E='),
                                  ),
                                ),
                                SizedBox(width: 6.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(viewModel.trophies.data![index].name!,
                                          softWrap: true,
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.clip),),),
                                    SizedBox(height: 5.0),
                                    sessio.data!.trophiesId!.toString().contains(viewModel.trophies.data![index].id.toString())? Text(
                                        'ACONSEGUIT',
                                        style: TextStyle(color: Colors.green)): Text("No aconseguit", style: TextStyle(color: Colors.grey)),
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

          ) : Text("res"),
        ),
      );
    })
    );

  }

}