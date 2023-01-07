import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/viewModels/AnotherUserViewModel.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../../utils/Session.dart';

class AnotherProfile extends StatelessWidget {
  AnotherProfile({super.key, required this.selectedUser, required this.selectedId});
  String selectedUser;
  String selectedId;
  final double coverHeight = 280;
  final double profileHeight = 144;
  late List <String> usersList = [];
  final Session sessio = Session();
  final AnotherUserViewModel viewModel = AnotherUserViewModel();
  late UserResult useraux = viewModel.mainUser as UserResult;

  @override
  void initState() {
    viewModel.setUserSelected(selectedId);
    viewModel.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    //viewModel.setSessionRequests(sessio.data.id.toString());
    viewModel.setMyFriends(sessio.data.id.toString());
    viewModel.requestedUsersById(sessio.data.id.toString());
    viewModel.setUserSelected(selectedId);
    viewModel.selectUserById(selectedId);
    viewModel.notifyListeners();

    return ChangeNotifierProvider<AnotherUserViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<AnotherUserViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("User Profile"),
              backgroundColor: MyColorsPalette.lightBlue,
            ),
            backgroundColor: Colors.grey[200],
            // key: _scaffoldKey,
            drawer: MyDrawer(
                "AnotherProfile",  Session(), username: "SuperJuane",
                email: "juaneolivan@gmail.com"),
            body: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(),
                SizedBox(height: 18),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        selectedUser,
                        style: TextStyle(fontSize: 28, color: Colors.teal),
                      ),
                    ]
                ),
                buildContent(),
                const SizedBox(height: 20),

                  viewModel.usersRequested.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
                  viewModel.usersRequested.status == Status.ERROR? Text("ERROR"):
                  viewModel.usersRequested.status == Status.COMPLETED?
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: viewModel.friend==false? <Widget>[
                    const Text (
                      'Afegir amic:  ',
                      style: TextStyle(
                          fontSize: 18, height: 1.4, color: Colors.black54),
                    ),
                    true? IconButton(
                      iconSize: 40,
                      icon: Icon(
                          (viewModel.afegit == false) ? Icons.favorite_outline : Icons.favorite,
                          color: MyColorsPalette.lightRed),
                      onPressed: () {
                        if (viewModel.afegit == true) {
                          viewModel.deleteFriendById(sessio.data.id.toString(), selectedId);
                          var aux = int.parse(selectedId);
                          sessio.data.sentRequestsIds!.remove(aux);
                        }
                        else {
                          viewModel.putFriendById(sessio.data.id.toString(), selectedId);
                          var aux = int.parse(selectedId);
                          sessio.data.sentRequestsIds!.add(aux);
                        }
                        viewModel.afegit = !viewModel.afegit;
                        viewModel.notifyListeners();
                      },


                      ) : const Text(" "),
                    ]:
                      <Widget>[
                          const Text(
                           'Ja sou amics!    ',
                           style: TextStyle(
                               fontSize: 20, height: 1.6, color: Colors.lightGreen),
                          ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.redAccent)),
                          child: const Text ('Eliminar'),
                          onPressed: (){
                            viewModel.deleteFriendById(sessio.data.id.toString(), selectedId);
                            var aux = int.parse(selectedId);
                            sessio.data.friendsId!.remove(aux);
                            viewModel.afegit = false;
                            viewModel.friend = false;
                            viewModel.notifyListeners();
                          },
                        ),

                      ],

                  ) : const Text(""),
                const SizedBox(height: 30),

                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_rounded, color: Colors.amber),
                        Text('    ${viewModel.mainUser.data!.creationDate!}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.alternate_email, color: Colors.amber),
                        Text('     ${viewModel.mainUser.data!.email!}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.workspace_premium, color: Colors.amber),
                        Text('     ${viewModel.mainUser.data!.role!}'),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on_outlined, color: Colors.amber),
                      Text('     ${viewModel.mainUser.data!.points!}'),
                    ],
                  ),






                /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ja has enviat una sol·licitud a aquest usuari',
                          style: TextStyle(fontSize: 28, color: Colors.teal),
                        ),

                        FloatingActionButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            viewModel.deleteFriendById('13658', selectedId);
                          },
                        ),
                      ],
                  ): const Text(""),*/

                ],
              ),
            /*
                body: Container(
                    color: MyColors.warning,
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                          MyColorsPalette.orange)),
                      child: const Text('Add to friends'),
                      onPressed: () {

                      },
                    )
                 */
              );
        })
    );
  }

  Widget buildContent() => Column(
      children: [
      SizedBox(height: 12),
      Text (
        //viewModel.mainUser.data!.username!,
        selectedUser,
        style: TextStyle(fontSize: 20, height: 1.4, color: Colors.grey),
      ),
    ],
  );

  Widget buildTop() {
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;
    return Stack (
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container (
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfilePicture(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://tecnohotelnews.com/wp-content/uploads/2019/05/shutterstock_214016374.jpg'),
      height: coverHeight,
      width: double.infinity,
      //fit: BoxFit.cover,
  );

  Widget buildProfilePicture() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage('https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
  );



}