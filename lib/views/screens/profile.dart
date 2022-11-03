import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import '../widgets/search_locations.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
import 'package:CatCultura/viewModels/AnotherUserViewModel.dart';



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
  final UsersViewModel viewModel = UsersViewModel();
  late List <String> usersList = [];
  late List <String> usersSuggList = [];


  Widget build(BuildContext context) {
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
          drawer: const MyDrawer("Profile",
              username: "Superjuane", email: "juaneolivan@gmail.com"),
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.amberAccent)),
                    child: const Text('Configuració'),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/editProfile');
                    },
                  ),
                ),


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
                          });
                          // ignore: use_build_context_synchronously
                          //if (selectedUser != '') Navigator.popAndPushNamed(context, '/another-user-profile');
                          if (selectedUser != '') Navigator.pushNamed(context, '/another-user-profile', arguments: selectedUser);
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
          }
        )
    );
  }
/*
  class usersListSwitch extends StatefulWidget {
    final List<UserResult> users;

    const usersListSwitch({super.key, required this.users});
    @override
    State<usersListSwitch> createState() => usersListSwitchState();
  }

  class usersListSwitchState extends State<usersListSwitch> {
    late List<UserResult> users = widget.users;

    Widget _buildUserShort(int idx) {
      return UserInfoTile(user: users[idx]);
    }

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildUserShort(i);
        });

    }
  }
*/
/*

  final List <String> usersSuggList = [
    'Alejandro',
    'Manolo',
    'Pepe',
    'Joanna',
    'Adiosbuenosdias',
  ];
*/

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
