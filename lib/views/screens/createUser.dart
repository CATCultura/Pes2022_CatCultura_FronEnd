//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:provider/provider.dart';
import '../../data/response/apiResponse.dart';
import '../../viewModels/LoginViewModel.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  final LoginViewModel viewModel = LoginViewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  bool initial = true;

  String? filltext(String param) {
    if (param.length == 0 && !initial) {
      return AppLocalizations.of(context)?.errorMessageCreateAccount;
    }
    else if (param.length < 6 && !initial) {
      return AppLocalizations.of(context)?.errorCharactersMessageCreateAccount;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<LoginViewModel>(builder: (context, value, _) {
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
              child: Text(
                AppLocalizations.of(context)!.descriptionCreateAccount,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                decoration: InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.of(context)?.nameAndSurnameInputBoxLabel,
                    errorText: filltext(nameController.text),
                    hintStyle: const TextStyle(
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
                maxLength: 12,
                decoration: InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.of(context)?.userNameInputBoxLabel,
                    errorText: filltext(userController.text),
                    hintStyle: const TextStyle(
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
                decoration: InputDecoration (
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.of(context)?.emailInputBoxLabel,
                    errorText: filltext(emailController.text),
                    hintStyle: const TextStyle(
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
                    icon: Icon (
                      Icons.remove_red_eye,
                      color: showPassword ? Colors.deepOrangeAccent : Colors.grey,
                    )
                  ),
                    labelText: AppLocalizations.of(context)?.passwordInputBoxLabel,
                    errorText: filltext(nameController.text),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                  child:  Text(AppLocalizations.of(context)!.createAccount),
                  onPressed: () {
                    initial = false;
                    viewModel.notifyListeners();

                    if (nameController.text.length != 0 && userController.text.length != 0 &&
                    emailController.text.length != 0 && passwordController.text.length != 0) {
                      Navigator.popAndPushNamed(context, '/userTags',
                          arguments: CrearUserArgs(
                              nameController.text, userController.text,
                              emailController.text, passwordController.text));
                    }
                  }
                ),
            ),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              },
              child: Text(
                AppLocalizations.of(context)!.alreadyAccount,
                style: const TextStyle(
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