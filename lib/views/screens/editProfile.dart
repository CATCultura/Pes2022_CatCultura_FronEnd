//import 'dart:io';

import 'package:CatCultura/models/SessionResult.dart';
import 'package:CatCultura/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/Session.dart';
//import 'package:tryproject2/constants/theme.dart';
import '../../viewModels/UsersViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  final UsersViewModel viewModel = UsersViewModel();

  TextEditingController passwordController = TextEditingController();
  bool showPasswordNew = false;
  bool correctText = false;

  String? filltext(String param) {
    if (param.length == 0) {
      return AppLocalizations.of(context)?.emptyFieldText;
    }
    else if (param.length < 6) {
      return AppLocalizations.of(context)?.errorCharactersMessageCreateAccount;
    }
    else {
      correctText = true;
    }
    return null;
  }

  final Session session = Session();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UsersViewModel>(builder: (context, value, _) {

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
            title: Center(
              child: Text(
                  AppLocalizations.of(context)!.editProfileText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                  )
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/profile');
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/profileSettings');
                },
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 16, top: 5, right: 16),
            /*
                si està el teclat obert, al clicar a qualsevol punt
                de la pantalla, desapareix
                */
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 5,
                                color: Colors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2, blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10)
                                )
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://avatars.githubusercontent.com/u/99893934?s=400&u=cc0636970f96e71b96dfb4696945dc0a95ebb787&v=4")
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 35, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: AppLocalizations.of(context)?.nameAndSurnameInputBoxLabel,
                          enabled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: session.data.nameAndSurname,
                          hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 30, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: AppLocalizations.of(context)?.userNameInputBoxLabel,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: session.data.username,
                          enabled: false,
                          hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: AppLocalizations.of(context)?.emailInputBoxLabel,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: session.data.email,
                          enabled: false,
                          hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !showPasswordNew,
                      decoration: InputDecoration(
                          errorText: filltext(passwordController.text),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPasswordNew = !showPasswordNew;
                              });
                            },
                            icon: Icon (
                              Icons.remove_red_eye,
                              color: showPasswordNew ? Colors.blueAccent : Colors.grey,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 3),
                          labelText: AppLocalizations.of(context)!.newPasswordInput,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 15, right: 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/userEditTags');
                        },
                        child: Text(AppLocalizations.of(context)!.editTagsButton,
                          style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 2.2,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 15, right: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent)),
                              child: Text(AppLocalizations.of(context)!.cancelButton,
                                style: const TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 2.2,
                                    color: Colors.white
                                ),
                              ),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/profile');
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent)),
                              child: Text(AppLocalizations.of(context)!.saveButton,
                                style: const TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 2.2,
                                    color: Colors.white
                                ),
                              ),
                              onPressed: () {
                                viewModel.notifyListeners();
                                if (correctText) {
                                  viewModel.editarcompte(passwordController.text);
                                }
                                Navigator.popAndPushNamed(context, '/editProfile');
                              },
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
