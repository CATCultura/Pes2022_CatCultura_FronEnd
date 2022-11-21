import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

class AnotherUserViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  //ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();
  ApiResponse<String> addFriendResult = ApiResponse.loading();
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

  setFriendResult(ApiResponse<String> response){
    addFriendResult = response;
    notifyListeners();
  }

    Future<void> selectUserById(String id) async{
    await _usersRepo.getUserById(id).then((value){
      setUsersSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersSelected(ApiResponse.error(error.toString())));
  }

  Future<void> putFriendById(String userId, String? otherUserId) async{
    if(otherUserId != null) {
      await _usersRepo.addFavouriteByUserId(userId, int.parse(otherUserId)).then((value) {
        setFriendResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setFriendResult(ApiResponse.error(error.toString())));
    }

  }

  Future<void> deleteFriendById(String userId, String? otherUserId) async{
    if(otherUserId != null){
      await _usersRepo.deleteFavouriteByUserId(userId, int.parse(otherUserId)).then((value){
        setFriendResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setFriendResult(ApiResponse.error(error.toString())));
    }
  }


}