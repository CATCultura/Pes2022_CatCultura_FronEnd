import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/viewModels/RequestsUserViewModel.dart';
import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';


class FriendRequests extends StatelessWidget {

  final RequestsUserViewModel viewModel = RequestsUserViewModel();
  late List <String> usersList = [];
  final Session sessio = Session();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    List names = ["Juanito Perez", "Agustí Gàllego", "SuperJuane"];
    viewModel.receivedUsersById(sessio.data.id.toString());
    //if (viewModel.usersReceived.status == Status.COMPLETED) {
   /*   for (var i = 0; i < 1; i++) {
        usersList.add(viewModel.usersReceived.data![i].username);
      }*/
    //}
    viewModel.notifyListeners();
    return ChangeNotifierProvider<RequestsUserViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<RequestsUserViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: const Text("Peticions d'amistat"),
              backgroundColor: MyColorsPalette.lightBlue,
            ),
            backgroundColor: MyColors.bgColorScreen,
            // key: _scaffoldKey,
            drawer: const MyDrawer("Profile",
                username: "Superjuane", email: "juaneolivan@gmail.com"),
            body: Container(
              child: viewModel.usersReceived.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
              viewModel.usersReceived.status == Status.ERROR? Text(viewModel.usersReceived.toString()):
              viewModel.usersReceived.status == Status.COMPLETED? ListView.builder(
                itemCount: viewModel.usersReceived.data!.length,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [
                              Container(
                                width: 55.0,
                                height: 55.0,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.green,
                                  backgroundImage: NetworkImage('https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
                                ),
                              ),
                              SizedBox(width: 6.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(viewModel.usersReceived.data![index].username!, style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  SizedBox(height:5.0),
                                  Text('CATCultura', style: TextStyle(color: Colors.grey)),

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
                                color: Colors.green,
                              ),
                              onPressed: () {
                               viewModel.putFriendById(sessio.data.id.toString(), viewModel.usersReceived.data![index].id!);
                               var aux = int.parse(viewModel.usersReceived.data![index].id!);
                               sessio.data.receivedId!.remove(aux);
                               sessio.data.friendsId!.add(aux);
                              },
                            ),
                          ),
                         // SizedBox(width: 1.0,),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
                            child: IconButton(
                              iconSize: 40,
                              icon: Icon(
                                  Icons.no_accounts,
                                  color: Colors.red,
                              ),
                              onPressed: () {
                                viewModel.deleteFriendById(sessio.data.id.toString(), viewModel.usersReceived.data![index].id!);
                                var aux = int.parse(viewModel.usersReceived.data![index].id!);
                                sessio.data.receivedId!.remove(aux);
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
          );
        })
    );
  }




}