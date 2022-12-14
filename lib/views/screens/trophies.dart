import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/TrophyViewModel.dart';
import '../../data/response/apiResponse.dart';


class Trophies extends StatelessWidget {

  final TrophyViewModel viewModel = TrophyViewModel();
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    viewModel.receivedTrophies();
    viewModel.notifyListeners();
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
        drawer: const MyDrawer("Profile",
            username: "Superjuane", email: "juaneolivan@gmail.com"),
        body: Container(
          child: viewModel.trophies.status == Status.LOADING ? const SizedBox(
            child: Center(child: CircularProgressIndicator()),) :
          viewModel.trophies.status == Status.ERROR ? Text(
              viewModel.trophies.toString()) :
          viewModel.trophies.status == Status.COMPLETED ? ListView.builder(
            itemCount: viewModel.trophies.data!.length,
            shrinkWrap: true,
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
                                      'https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
                                ),
                              ),
                              SizedBox(width: 6.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(viewModel.trophies.data![index].name!,
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5.0),
                                  Text('CATCultura',
                                      style: TextStyle(color: Colors.grey)),

                                ],
                              ),
                            ],
                          ),
                        ],

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