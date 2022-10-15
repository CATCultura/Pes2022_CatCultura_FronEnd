//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulEditProfile(),
    );
  }
}

class StatefulEditProfile extends StatefulWidget {
  const StatefulEditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulEditProfile> createState() => _StatefulEditProfileState();
}

class _StatefulEditProfileState extends State<StatefulEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
             const CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/99893934?s=400&u=cc0636970f96e71b96dfb4696945dc0a95ebb787&v=4")
               ),
              Container(
                margin: const EdgeInsets.all(50),
                child: const Text(
                  'Edita el teu perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nom",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: TextField(
                  controller: surnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Cognoms",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: TextField(
                  controller: userController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nom usuari",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contrasenya'),
                  obscureText: true,
                ),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amberAccent)),
                  child: const Text('Guarda'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/editProfile');
                  },
                ),
              ),
            ]
        )
    );
  }
}
