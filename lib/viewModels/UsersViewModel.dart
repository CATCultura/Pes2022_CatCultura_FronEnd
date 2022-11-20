import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

class UsersViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();

  bool waiting = true;
  int errorN = 0;


  setUsersList(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersList = response;
    notifyListeners();
  }

  setUsersSelected(ApiResponse<UserResult> response){
    mainUser = response;
    notifyListeners();
  }

  Future<void> fetchUsersListApi() async {
    await _usersRepo.getUsers().then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersList(ApiResponse.error(error.toString())));
  }

  Future<void> iniciarSessio(String n, String p) async {
    //if(n != "") {
      await _usersRepo.iniSessio(n, p).then((value) {
        setUsersSelected(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setUsersSelected(ApiResponse.error(error.toString())));
    //} else errorN = 1;
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