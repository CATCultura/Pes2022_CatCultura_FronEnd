import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class AnotherUserViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  //ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();
  ApiResponse<String> addFriendResult = ApiResponse.loading();
  ApiResponse<List<UserResult>> usersRequested = ApiResponse.loading();
  bool afegit = false;
  bool friend = false;
  String id = '';
  final Session sessio = Session();

  setUsersSelected(ApiResponse<UserResult> response){
    mainUser = response;
    notifyListeners();
  }

  setUserSelected(String idUser){
    id = idUser;
    notifyListeners();
  }

  setUsersRequested(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersRequested = response;
    late List <String> usersList = [];

    if(response.status == Status.COMPLETED){
      if (sessio.data.sentRequestsIds.toString().contains(id)) afegit = true;
      if (sessio.data.friendsId.toString().contains(id)) friend = true;

     /* for (int i = 0; i < usersRequested.data!.length; ++i) {
        usersList.add(usersRequested.data![i].id!);
      }


      if (usersList.contains(id)) afegit = true;
      */
    }
    else if (response.status == Status.ERROR){
      afegit = false;
      if (sessio.data.friendsId.toString().contains(id)) friend = true;
    }
    notifyListeners();
  }

  setSession(ApiResponse<List<UserResult>> response) {
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersRequested = response;
    List<int> aux = [];
    for (int i = 0; i < usersRequested.data!.length; ++i){
      var auxiliar = int.parse(response.data!.elementAt(i).id!);
      aux.add(auxiliar);
    }
    sessio.data.sentRequestsIds = aux;

    /*for (int i = 0; i < usersRequested.data!.length; ++i){
      var aux = int.parse(response.data!.elementAt(i).id!);
      sessio.data.requestedId!.add(aux);
    }
     */

    //late List <String> usersList = [];
  }

  setSessionFriends(ApiResponse<List<UserResult>> response) {
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersRequested = response;
    List<int> aux = [];
    for (int i = 0; i < usersRequested.data!.length; ++i){
      var auxiliar = int.parse(response.data!.elementAt(i).id!);
      aux.add(auxiliar);
    }
    sessio.data.friendsId = aux;
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


  Future<void> requestedUsersById(String id) async{
    await _usersRepo.getRequestedsById(id).then((value){
      setUsersRequested(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersRequested(ApiResponse.error(error.toString())));
  }

/*
  Future<void> setSessionRequests(String id) async{
    await _usersRepo.getRequestedsById(id).then((value){
      setSession(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setSession(ApiResponse.error(error.toString())));
  }
 */

  Future<void> setMyFriends(String id) async{
    await _usersRepo.getFriendsById(id).then((value){
      setSessionFriends(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setSessionFriends(ApiResponse.error(error.toString())));
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