import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

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
        title: const Text("My Profile"),
        backgroundColor: MyColorsPalette.lightBlue,
      ),
      backgroundColor: MyColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: const MyDrawer(
          "Profile", username: "Superjuane", email: "juaneolivan@gmail.com"),
      body: Column(
        /*
          color: MyColors.warning,
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          */
          children: [
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
                if (selectedUser != '') Navigator.popAndPushNamed(context, '/another-user-profile');
              },
              // onPressed: (){},
            ),

          ]
      ),
    );
  }
  final List <String> usersList = [
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