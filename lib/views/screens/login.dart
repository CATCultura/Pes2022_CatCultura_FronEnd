//import 'dart:io';

import 'package:CatCultura/main.dart';
import 'package:CatCultura/repository/ChatRepository.dart';
import 'package:CatCultura/utils/routes/allScreens.dart';
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
  TextEditingController nameController = TextEditingController(/*text: "admin"*/);
  TextEditingController passwordController = TextEditingController(/*text: "admin"*/);
  bool showPassword = false;
  bool initial = true;
  bool error_message = false;

  String? filltext(String param, String type) {
   /* if (error_message) {
      if (type == "user") {
        return "Usuari incorrecte";
      } else {
        return "Contrasenya incorrecta";
      }
    }*/
     if (param.length == 0 && !initial) {
      return "Camp requerit";
    }
    return null;
  }

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
                      errorText: filltext(nameController.text, "user"),

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
                    errorText: filltext(passwordController.text, "pass"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = ! showPassword;
                        });
                      },
                      icon: Icon (
                        Icons.remove_red_eye,
                        color: showPassword ? Colors.deepOrangeAccent : Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.of(context)?.passwordInputBoxLabel,
                  ),
                ),
              ),

              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: ElevatedButton(
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                    child: Text(AppLocalizations.of(context)!.loginButton,
                      style: TextStyle (
                          color:Colors.white
                      ),
                    ),
                    onPressed: ()  {
                      initial = false;
                      if (nameController.text.length != 0 && passwordController.text.length != 0) error_message = true;
                      if (nameController.text.length != 0 && passwordController.text.length != 0) {
                        viewModel.iniciarSessio(nameController.text.replaceAll(' ', ''), passwordController.text);
                      }
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
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
              ),
            ],
          )
              : viewModel.mainUser.status == Status.LOADING? const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          )
              : viewModel.mainUser.status == Status.ERROR? Error()
              : viewModel.mainUser.status == Status.COMPLETED? Complete()
              : Text("CORRECT")
        )
    );
        }));
  }
}

class Complete extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ChatRepository().connect();
    Future.microtask(() =>
        Navigator.pushReplacementNamed(context, '/home')
    );
    return Container();
  }
}

class Error extends StatelessWidget {
  final LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    ChatRepository().connect();
    Future.microtask(() =>
        Navigator.pushReplacementNamed(context, '/login')
    );
    return Container();
  }
}