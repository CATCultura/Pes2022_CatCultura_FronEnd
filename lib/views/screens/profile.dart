import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../../utils/Session.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/search_locations.dart';
import '../../data/response/apiResponse.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulProfile(),
    );
  }
}

class StatefulProfile extends StatefulWidget {
  const StatefulProfile({Key? key}) : super(key: key);

  @override
  State<StatefulProfile> createState() => _StatefulProfileState();
}


class _StatefulProfileState extends State<StatefulProfile>  {

  String selectedUser = '';
  String selectedId = '';
  final UsersViewModel viewModel = UsersViewModel();
  late List <String> usersList = [];
  late List <String> usersSuggList = [];
  final double coverHeight = 280;
  final double profileHeight = 144;
  final Session sessio = Session();

  @override
  Widget build(BuildContext context) {
    viewModel.fetchUsersListApi();
    return ChangeNotifierProvider<UsersViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UsersViewModel>(builder: (context, value, _) {
         return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.myProfile),
            backgroundColor: Colors.orangeAccent,
          ),
           backgroundColor: Colors.white,
          // key: _scaffoldKey,
          drawer: MyDrawer("Profile", Session()),
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2, blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10)
                              )
                            ],
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('resources/img/logo.png')
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Text(
                      sessio.data.nameAndSurname!,
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    Text(
                      sessio.data.username.toString(),
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/ranking');
                              },
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.points,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    sessio.data.points.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                          140, 123, 35,1),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 30,
                              ),
                              child: Container(
                                height: 40,
                                width: 1,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/trophies');
                              },
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.trophies,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    sessio.data!.trophiesId!.length.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                          140, 123, 35,1),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  ]
                ),

                const SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      // padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.orangeAccent)),
                        child: Text(AppLocalizations.of(context)!.config),
                        onPressed: () {
                          Navigator.pushNamed(context, '/editProfile');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  // padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.orangeAccent)),
                    child: Text(AppLocalizations.of(context)!.friendRequests),
                    onPressed: () {
                      Navigator.pushNamed(context, '/friendRequests');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                /*viewModel.usersList.status == Status.LOADING? const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                ):
                viewModel.usersList.status == Status.ERROR? Text(viewModel.usersList.toString()):
                viewModel.usersList.status == Status.COMPLETED?

                 */
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  // padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.orangeAccent)),
                      child: Text (AppLocalizations.of(context)!.findUsers),
                      onPressed: ()async{
                          /*
                          for (var i = 0; i < 20; i++) {
                            usersList.add(viewModel.usersList.data![i].username!);
                            usersSuggList.add(viewModel.usersList.data![i].username!);
                          }
                          //usersList[0] = viewModel.usersList.data![0].username!;

                          final finalResult = await showSearch(
                            context: context,
                            delegate: SearchLocations(
                              allUsers: usersList,
                              allUsersSuggestion: usersSuggList,
                            ),
                          );
                          setState((){
                            var pos = 0;
                            for (var i = 0; i < usersList.length; i++){
                              if (usersList[i] == finalResult!) pos = i;
                            }
                            selectedUser = viewModel.usersList.data![pos].nameAndSurname!;
                            selectedId = viewModel.usersList.data![pos].id!;
                          });
                           */
                          // ignore: use_build_context_synchronously
                          //if (selectedUser != '') Navigator.pushNamed(context, '/another-user-profile', arguments: AnotherProfileArgs(selectedUser, selectedId));
                          Navigator.pushNamed(context, '/allUsers');
                      },

                    ),
                  /*icon: const Icon(Icons.search), label: const Text("Search users"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepOrange,
                    side: const BorderSide(color: Colors.orange),
                  ),*/

                  // onPressed: (){},
                ),
                const SizedBox(height: 30),
                sessio.data.role.toString() == "ADMIN" ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*
                    Column(
                      children: [
                        Icon(Icons.calendar_month_rounded, color: Colors.amber),
                        Text(sessio.data.creationDate.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.alternate_email, color: Colors.amber),
                        Text(sessio.data.email.toString()),
                      ],
                    ),
                    */
                    Column(
                      children: [
                        Icon(Icons.workspace_premium, color: Colors.amber),
                        Text(sessio.data.role.toString()),
                      ],
                    ),
                  ],
                ):Text("")
              ],
            ),
          ),
         );
      })
    );
  }
}

/*
child: const CircleAvatar(
radius: 60.0,
backgroundColor: MyColorsPalette.white,
backgroundImage: NetworkImage(
"https://avatars.githubusercontent.com/u/99893934?s=400&u=cc0636970f96e71b96dfb4696945dc0a95ebb787&v=4")),
child: const Text(
"body",
style: TextStyle(fontSize: 30, color: Colors.white),
),*/

