import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: MyColorsPalette.lightBlue,
      ),
      backgroundColor: MyColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: const MyDrawer(
          "Profile", username: "Superjuane", email: "juaneolivan@gmail.com"),
      body: Container(
          color: MyColors.warning,
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                MyColorsPalette.orange)),
            child: const Text('Buscar usuaris'),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/search-user');
            },
          )
      ),
    );
  }
}