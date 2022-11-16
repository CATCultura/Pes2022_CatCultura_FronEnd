//import 'dart:io';

import 'package:CatCultura/main.dart';
import 'package:flutter/material.dart';

import '../../constants/theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)?.userNameInputBoxLabel,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)?.passwordInputBoxLabel,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text(AppLocalizations.of(context)!.forgotPassword,),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.orange)),
                  child: Text(AppLocalizations.of(context)!.loginButton),
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
                Text(AppLocalizations.of(context)!.signUpPrompt),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.signUpButton,
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/createUser');
                  },
                )
              ],
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.guestMode,
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
