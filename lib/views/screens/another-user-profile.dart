import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CatCultura/viewModels/AnotherUserViewModel.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';

import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../../utils/Session.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';



class AnotherProfile extends StatefulWidget {
  const AnotherProfile({super.key, required this.selUser, required this.selId});
  final String selUser;
  final String selId;

  @override
  State<AnotherProfile> createState() => _AnotherProfileState();
}

class _AnotherProfileState extends State<AnotherProfile> {

  //AnotherProfile({super.key, required this.selectedUser, required this.selectedId});
  late String selectedUser = widget.selUser;
  late String selectedId = widget.selId;
  final double coverHeight = 280;
  final double profileHeight = 144;
  late List <String> usersList = [];
  final Session sessio = Session();
  final AnotherUserViewModel viewModel = AnotherUserViewModel();
  //late UserResult useraux = viewModel.mainUser as UserResult;

  @override
  void initState() {
    viewModel.setUserSelected(selectedId);
    viewModel.setMyFriends(sessio.data.id.toString());
    viewModel.requestedUsersById(sessio.data.id.toString());
    //viewModel.setUserSelected(selectedId);
    viewModel.selectUserById(selectedId);
    viewModel.reportedUsersById(sessio.data.id.toString());
  }

  @override
  Widget build(BuildContext context) {

    viewModel.setMyFriends(sessio.data.id.toString());
    viewModel.requestedUsersById(sessio.data.id.toString());
    viewModel.setUserSelected(selectedId);
    viewModel.selectUserById(selectedId);
    viewModel.reportedUsersById(sessio.data.id.toString());
    viewModel.notifyListeners();

    return ChangeNotifierProvider<AnotherUserViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<AnotherUserViewModel>(builder: (context, value, _) {
          return Scaffold(
              appBar: AppBar(
                title:  Text(AppLocalizations.of(context)!.userProfile),
                backgroundColor: Colors.orangeAccent,
              ),
              backgroundColor: Colors.white,
              body: viewModel.mainUser.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
              viewModel.mainUser.status == Status.ERROR? Text("ERROR"):
              viewModel.mainUser.status == Status.COMPLETED? ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(),
                  SizedBox(height: 18),
              viewModel.usersReported.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
              viewModel.usersReported.status == Status.ERROR? Text("ERROR"):
              viewModel.usersReported.status == Status.COMPLETED? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          viewModel.mainUser.data!.nameAndSurname.toString(),
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(width: 10),
                        //sessio.data.reportedUserIds!.contains(int.parse(selectedId))?
                         !viewModel.reported ? IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.report_problem_outlined,
                            color: Colors.redAccent,
                          ),
                          onPressed: () async {
                            viewModel.reportUser(sessio.data.id.toString(), selectedId);
                            sessio.data.reportedUserIds!.add(int.parse(selectedId));
                            await viewModel.reportedUsersById(sessio.data.id.toString());
                            viewModel.reported = true;
                            viewModel.notifyListeners();
                            // Navigator.pushNamed(context, '/another-user-profile',
                            //     arguments: AnotherProfileArgs(selectedUser, selectedId));
                          },

                        ) : Text(""),
                      ]
                  ):Text(""),
                  buildContent(),
                  viewModel.usersRequested.status == Status.LOADING? const SizedBox(child: Center(child: CircularProgressIndicator()),):
                  viewModel.usersRequested.status == Status.ERROR? Text("ERROR"):
                  viewModel.usersRequested.status == Status.COMPLETED?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: viewModel.friend==false? <Widget>[
                      Text (
                        '${AppLocalizations.of(context)!.addFriend}    ',
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

                  ): const Text(""),
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
                      Text('     ${viewModel.mainUser.data!.points!} ${AppLocalizations.of(context)!.points}'),
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
              ):Text("Error")
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
        style: TextStyle(
            fontSize: 20,
            height: 1.4,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w300
        ),
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
    color: Colors.white,
    child: Image.asset('resources/img/logo.png'),
    height: coverHeight,
    width: double.infinity,
    //fit: BoxFit.cover,
  );

  Widget buildProfilePicture() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.white,
    backgroundImage: AssetImage('resources/img/logo.png'),
    //backgroundImage: NetworkImage('https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
  );



}