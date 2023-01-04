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

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    viewModel.fetchUsersListApi();
    return ChangeNotifierProvider<UsersViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UsersViewModel>(builder: (context, value, _) {
         return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: const Text("My Profile"),
            backgroundColor: MyColorsPalette.lightBlue,
          ),
          backgroundColor: MyColors.bgColorScreen,
          // key: _scaffoldKey,
          drawer: MyDrawer("Profile", Session(),
              username: "Superjuane", email: "juaneolivan@gmail.com"),
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                buildTop(),

                Column(
                  children: [
                    Text(
                      sessio.data.username,
                      style: TextStyle(
                        color: Color.fromRGBO(230, 192, 2, 1),
                        fontFamily: 'Nunito',
                        fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Puntuació',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'Nunito',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  sessio.data!.points.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(
                                        140, 123, 35,1),
                                    fontFamily: 'Nunito',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Container(
                                height: 50,
                                width: 3,
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
                                    'Trofeus',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    sessio.data!.trophiesId!.length.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                          140, 123, 35,1),
                                      fontFamily: 'Nunito',
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
                      padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.amberAccent)),
                        child: const Text('Configuració'),
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
                  padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.amberAccent)),
                    child: const Text('Veure peticions amistat'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/friendRequests');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                viewModel.usersList.status == Status.LOADING? const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                ):
                viewModel.usersList.status == Status.ERROR? Text(viewModel.usersList.toString()):
                viewModel.usersList.status == Status.COMPLETED? Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.amberAccent)),
                      child: const Text ('Buscar Usuaris'),
                      onPressed: ()async{

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
                          // ignore: use_build_context_synchronously
                          if (selectedUser != '') Navigator.pushNamed(context, '/another-user-profile', arguments: AnotherProfileArgs(selectedUser, selectedId));
                        },

                    ),
                  /*icon: const Icon(Icons.search), label: const Text("Search users"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepOrange,
                    side: const BorderSide(color: Colors.orange),
                  ),*/

                  // onPressed: (){},
                ): Text("res"),
              ],
            ),
          ),
         );
      })
    );
  }


  Widget buildTop() {
    final bottom = profileHeight/4;
    return Stack (
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container (
          margin: EdgeInsets.only(bottom: bottom),
          child: buildProfilePicture(),
        ),

      ],
    );
  }


  Widget buildProfilePicture() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage('https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
  );


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
