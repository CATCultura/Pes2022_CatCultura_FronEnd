import 'package:flutter/material.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';

import '../widgets/search_locations.dart';

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

  @override
  Widget build(BuildContext context) {

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
            OutlinedButton.icon(
              icon: const Icon(Icons.search), label: const Text("Search users"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepOrange,
                side: const BorderSide(color: Colors.orange),
              ), onPressed: () async{
              final finalResult = await showSearch(
                context: context,
                delegate: SearchLocations(
                  allUsers: usersList,
                  allUsersSuggestion: usersSuggList,
                ),
              );
              setState((){
                selectedUser = finalResult!;
              });
              // ignore: use_build_context_synchronously
              if (selectedUser != '') Navigator.pushNamed(context, '/another-user-profile');
            },
              // onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
  final List <String> usersList = [ //viewModel.usersList
    'Alejandro',
    'Manolo',
    'Pepe',
    'Joanna',
    'Adiosbuenosdias',


  ];

  final List <String> usersSuggList = [
    'Alejandro',
    'Manolo',
    'Pepe',
    'Joanna',
    'Adiosbuenosdias',
  ];


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
