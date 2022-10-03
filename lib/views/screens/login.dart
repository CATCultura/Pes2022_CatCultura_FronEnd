import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryproject2/constants/theme.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: StatefulLogin(),
    );
  }
}

class StatefulLogin extends StatefulWidget {
  const StatefulLogin({Key? key}) : super(key: key);

  @override
  State<StatefulLogin> createState() => _StatefulLoginState();
}

class _StatefulLoginState extends State<StatefulLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 490,
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                //child: Image.network("https://cdn.logo.com/hotlink-ok/logo-social.png", height: 18.0 ,scale: 1.0,),
                //child: Image.file(File("C:/Users/Juane Olivan/Documents/FlutterTest/tryproject2/resources/img/logo.png"), height: 18.0 ,scale: 1.0,),
                child: Image.asset('resources/img/logo3.png', scale: 2.0,)
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom d'usuari",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contrassenya',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Has oblidat la contrassenya?',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.orange)),
                  child: const Text('Iniciar sessió'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                    //Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                    Navigator.popAndPushNamed(context, '/home');
                    //Navigator.pushReplacementNamed(context, '/home');
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Encara no tens un compte?'),
                TextButton(
                  child: const Text(
                    'Crear compte',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
            TextButton(
              child: const Text(
                'Entrar com invitat',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                //signup screen
              },
            ),
          ],
        ));
  }
}
