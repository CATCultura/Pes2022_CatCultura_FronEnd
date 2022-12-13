//import 'dart:io';

import 'package:CatCultura/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';

import '../../constants/theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../viewModels/LoginViewModel.dart';
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
  final LoginViewModel viewModel = LoginViewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<LoginViewModel>(builder: (context, value, _) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: GestureDetector(
          onTap: () {
          FocusScope.of(context).unfocus();
          },
          child:
          viewModel.waiting? ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                  //child: Image.network("https://cdn.logo.com/hotlink-ok/logo-social.png", height: 18.0 ,scale: 1.0,),
                  //child: Image.file(File("C:/Users/Juane Olivan/Documents/FlutterTest/tryproject2/resources/img/logo.png"), height: 18.0 ,scale: 1.0,),
                  child: Image.asset('resources/img/logo.png', scale: 2.0,)
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration (
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: AppLocalizations.of(context)?.userNameInputBoxLabel,
                  ),
                ),
              ),
              viewModel.errorN == 1? const Text("No funciona"): Text(""),

              Container(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextField(

                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration (
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = ! showPassword;
                        });
                      },
                      icon: const Icon (
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.of(context)?.passwordInputBoxLabel,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: Text(AppLocalizations.of(context)!.forgotPassword,
                      style: TextStyle (
                      color:Colors.deepOrangeAccent
                  )),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: ElevatedButton(
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                    child: Text(AppLocalizations.of(context)!.loginButton,
                      style: TextStyle (
                          color:Colors.white
                      ),
                    ),
                    onPressed: () async {
                      final b = await viewModel.iniciarSessio(nameController.text.replaceAll(' ', ''), passwordController.text).then((value){
                        debugPrint(value? "true":"false");
                      });
                      debugPrint(b? "2 - true":"2 - false");
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
                      style: TextStyle (
                          color:Colors.deepOrangeAccent
                      ),
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
                  style: TextStyle (
                      color:Colors.deepOrangeAccent
                  ),
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
              ),
            ],
          )
              : viewModel.mainUser.status == Status.LOADING? const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          )
              : viewModel.mainUser.status == Status.ERROR? Text(viewModel.mainUser.toString())
              : viewModel.mainUser.status == Status.COMPLETED? A(): Text("d")
        )
    );
        }));
  }
}

class A extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Navigator.popAndPushNamed(context, '/home');
        return Container();
  }
}
