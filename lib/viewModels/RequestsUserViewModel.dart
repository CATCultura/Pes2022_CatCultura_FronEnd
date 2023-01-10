import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';

class RequestsUserViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  //ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> mainUser = ApiResponse.loading();
  ApiResponse<String> addFriendResult = ApiResponse.loading();
  ApiResponse<List<UserResult>> usersReceived = ApiResponse.loading();
  ApiResponse<List<UserResult>> usersRequested = ApiResponse.loading();
  bool afegit = false;
  bool requested = false;
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

  setUsersReceived(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersReceived = response;
    List<int> aux = [];
    for (int i = 0; i < usersReceived.data!.length; ++i){
      var auxiliar = int.parse(response.data!.elementAt(i).id!);
      aux.add(auxiliar);
    }
    sessio.data.receivedRequestsIds = aux;
    notifyListeners();

    /*
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersReceived = response;
    late List <String> usersList = [];
    if(response.status == Status.COMPLETED){
      for (int i = 0; i < usersReceived.data!.length; ++i) {
        usersList.add(usersReceived.data![i].id!);
      }
      if (usersList.contains(id)) afegit = true;
    }
    else if (response.status == Status.ERROR) afegit = false;
    notifyListeners();
     */
  }

  setUsersRequested(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    debugPrint(response.toString());
    usersRequested = response;
    List<int> aux = [];
    for (int i = 0; i < usersRequested.data!.length; ++i){
      var auxiliar = int.parse(response.data!.elementAt(i).id!);
      aux.add(auxiliar);
    }
    sessio.data.sentRequestsIds = aux;
    notifyListeners();
  }


  setFriendResult(ApiResponse<String> response){
    addFriendResult = response;
    notifyListeners();
  }


  Future<void> receivedUsersById(String id) async{
    await _usersRepo.getReceivedById(id).then((value){
      setUsersReceived(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersReceived(ApiResponse.error(error.toString())));
  }


  Future<void> requestedUsersById(String id) async{
    await _usersRepo.getRequestedsById(id).then((value){
      setUsersRequested(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersRequested(ApiResponse.error(error.toString())));
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