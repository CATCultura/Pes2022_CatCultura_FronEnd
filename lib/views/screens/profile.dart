import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text("Perfil"),
        backgroundColor: Colors.amberAccent,
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
            Container(
                color: MyColors.warning,
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyColorsPalette.orange)),
                  child: const Text('Buscar usuaris'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/search-user');
                  },
                )),
          ],
        ),
      ),
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
