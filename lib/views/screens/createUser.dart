//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';

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
  final UsersViewModel viewModel = UsersViewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    viewModel.fetchUsersListApi();
    return ChangeNotifierProvider<UsersViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UsersViewModel>(builder: (context, value, _) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,50,0,0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child:
        viewModel.waiting? ListView(
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
                  fontSize: 20,
                  color: Colors.deepOrangeAccent,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Nom i cognoms",
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextField(
                controller: userController,
                decoration: const InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Nom d'usuari",
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Correu electrònic",
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextField(
                obscureText: !showPassword,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton (
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon (
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    )
                  ),
                    labelText: 'Contrasenya'
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                  child: const Text('Crea compte'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                    viewModel.crearcompte(nameController.text, userController.text, emailController.text, passwordController.text);
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
                color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ],
        )
            : viewModel.mainUser.status == Status.LOADING? const SizedBox(
          child: Center(child: CircularProgressIndicator()),
        )
            : viewModel.mainUser.status == Status.ERROR? Text(viewModel.mainUser.toString())
            : viewModel.mainUser.status == Status.COMPLETED? IniSessio(): Text("User Created")
      )
    );
        }));
  }
}

class IniSessio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Navigator.popAndPushNamed(context, '/login');
    return Container();
  }
}