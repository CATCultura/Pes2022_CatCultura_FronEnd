import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class LoginViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();

  bool waiting = true;
  int errorN = 0;


  setUsersSelected(ApiResponse<UserResult> response){
    mainUser = response;
    notifyListeners();
  }

  Future<void> iniciarSessio(String name, String pass) async {
    final sessio = Session();
    sessio.set("auth", "username=$name,password=$pass");
    final a = 2;
    await _usersRepo.iniSessio().then((value) {
      setUsersSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString())));
    waiting = false;
    notifyListeners();
  }

  Future<void> crearcompte(String n, String u, String e, String p) async {
    //if(n != "") {
    UserResult user = UserResult();
    user.nameAndSurname = n;
    user.username = u;
    user.email = e;
    user.password = p;
    await _usersRepo.postCreaCompte(user).then((value) {
      setUsersSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString())));
    //} else errorN = 1;
    waiting = false;
    notifyListeners();
  }
}