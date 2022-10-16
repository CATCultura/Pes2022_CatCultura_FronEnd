//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulCreateUser(),
    );
  }
}

class StatefulCreateUser extends StatefulWidget {
  const StatefulCreateUser({Key? key}) : super(key: key);

  @override
  State<StatefulCreateUser> createState() => _StatefulCreateUserState();
}

class _StatefulCreateUserState extends State<StatefulCreateUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,50,0,0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.asset(
                  width: 70,
                  height: 20,
                  'resources/img/logo2.png',
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.all(50),
            child: const Text(
              'Fes-te un compte i comença a gaudir de la cultura del teu voltant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.teal,
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
                style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
                child: const Text('Crea compte'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
              ),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text(
              'Ja tinc compte',
              style: TextStyle(
              fontSize: 15,
              color: Colors.teal,
              ),
            ),
          ),
        ]
      )
    );
  }
}