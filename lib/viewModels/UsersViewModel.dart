import 'dart:convert';
import 'package:CatCultura/models/SessionResult.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class UsersViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();
  final sessio = Session();
  final Codec<String, String> stringToBase64 = utf8.fuse(base64);

  ApiResponse<SessionResult> mainUser = ApiResponse.loading();

  ApiResponse<List<UserResult>> usersList = ApiResponse.loading();

  bool waiting = true;
  int errorN = 0;

  setUsersList(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    //debugPrint(response.toString());
    usersList = response;
    notifyListeners();
  }

  Future<void> fetchUsersListApi() async {
    await _usersRepo.getUsers().then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersList(ApiResponse.error(error.toString())));
  }

 /* Future<void> editarcompte(String password) async {
   // late String encoded = stringToBase64.encode("$user:$password");
    late String auth = "Basic $encoded";

    await _usersRepo.putEditUser(user).then((value) {
      setUsersSelected(ApiResponse.completed(value), auth);
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString()), null));
    //} else errorN = 1;
    waiting = false;
    // notifyListeners();
  }*/

  setUsersSelected(ApiResponse<SessionResult> response, String? auth){
    mainUser = response;
    if(response.status == Status.COMPLETED)sessio.data = response.data!;
    notifyListeners();
  }
}

