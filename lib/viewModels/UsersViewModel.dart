import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class UsersViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  ApiResponse<List<UserResult>> usersList = ApiResponse.loading();

  bool waiting = true;
  int errorN = 0;


  setUsersList(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersList = response;
    notifyListeners();
  }

  Future<void> fetchUsersListApi() async {
    await _usersRepo.getUsers().then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersList(ApiResponse.error(error.toString())));
  }

}