import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class LoginViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();
  final sessio = Session();
  final Codec<String, String> stringToBase64 = utf8.fuse(base64);

  ApiResponse<UserResult> mainUser = ApiResponse.loading();

  bool waiting = true;
  int errorN = 0;


  setUsersSelected(ApiResponse<UserResult> response, String? auth){
    // mainUser = response;
    mainUser.status = Status.COMPLETED;
    // if(auth != null) sessio.set("authorization", auth);
    notifyListeners();
  }

  Future<bool> iniciarSessio(String name, String pass) async {
    late String encoded = stringToBase64.encode("$name:$pass");
    late String auth = "Basic $encoded";
    sessio.set("authorization", auth);

    await _usersRepo.iniSessio().then((value) {
      setUsersSelected(ApiResponse.completed(value), auth);
      return Future.value(true);
    }).onError((error, stackTrace){
        setUsersSelected(ApiResponse.error(error.toString()),null);return Future.value(false);});
    waiting = false;
    return true;
    notifyListeners();
  }

  Future<void> crearcompte(String n, String u, String e, String p) async {
    //if(n != "") {
    UserResult user = UserResult();
    user.nameAndSurname = n;
    user.username = u;
    user.email = e;
    user.password = p;
    late String encoded = stringToBase64.encode("$u:$p");
    late String auth = "Basic $encoded";

    await _usersRepo.postCreaCompte(user).then((value) {
      setUsersSelected(ApiResponse.completed(value), auth);
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString()), null));
    //} else errorN = 1;
    waiting = false;
    // notifyListeners();
  }
}