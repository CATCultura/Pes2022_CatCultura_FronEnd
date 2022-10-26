import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

class AnotherUserViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  //ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();

/*
  setUsersList(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    usersList = response;
    notifyListeners();
  }
*/
  setUsersSelected(ApiResponse<UserResult> response){
    mainUser = response;
    notifyListeners();
  }

    Future<void> selectUserById(String id) async{
    await _usersRepo.getUserById(id).then((value){
      setUsersSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString())));
  }
}