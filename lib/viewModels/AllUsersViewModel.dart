import 'package:flutter/material.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import '../utils/Session.dart';

class AllUsersViewModel with ChangeNotifier{
  final _usersRepo = UsersRepository();

  ApiResponse<List<UserResult>> usersList = ApiResponse.loading();
  ApiResponse<UserResult> users = ApiResponse.loading();
  int errorN = 0;

  bool waiting = true;
  List<String> suggestions = [];
  int count = 0;
  Set<int> loadedPages = {};
  bool chargingNextPage = false;

  void setLoading(){
    usersList.status = Status.LOADING;
    notifyListeners();
  }

  void refresh(){
    usersList.status = Status.LOADING;
    loadedPages = {};
    notifyListeners();
  }

  setUsersList(ApiResponse<List<UserResult>> response){
    print("before userslist = response (with exit)");
    usersList = response;
    loadedPages.add(0);
    notifyListeners();
  }

  void setUsers(ApiResponse<UserResult> response){
    users = response;
    notifyListeners();
  }

  void addToUsersList(ApiResponse<List<UserResult>> apiResponse) {
    if(apiResponse.status == Status.COMPLETED && usersList.status == Status.COMPLETED){
      chargingNextPage = false;
      List<UserResult> aux = usersList.data!;
      aux.addAll(apiResponse.data!);
      usersList = ApiResponse.completed(aux);
      //mantaintEventsListToMap();
      //loadedPages.add(lastPage()+1);
    }
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    if(loadedPages.isEmpty) {
      loadedPages.add(0);
      await _usersRepo.getUsers().then((value) {
        setUsersList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setUsersList(ApiResponse.error(error.toString())));
      count++;
      debugPrint("UsersViewModel. times accesed fetchUsers: $count");
    }
    else{
      debugPrint("--all list : ${loadedPages}");
      debugPrint("--charging next page: ${lastPage()}");
      await _usersRepo.getUsersWithParameters(lastPage(),null, null).then((value) {
        addToUsersList(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setUsersList(ApiResponse.error(error.toString())));
    }
  }


  Future<void> redrawWithFilter(String filter) async{
    await _usersRepo.getUsersWithFilter(filter).then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersList(ApiResponse.error(error.toString())));
    debugPrint("UsersViewModel, accesed from filter redraw");
  }

  int lastPage(){
    int result = 0;
    final List<int> list = loadedPages.toList();
    if(list.isNotEmpty) result = list.reduce(max);
    return result;
  }
  void addNewPage() {
    loadedPages.add(lastPage()+1);
    chargingNextPage = true;
    notifyListeners();
    fetchUsers();
  }
/*
  Future<void> fetchUsersListApi() async {
    await _usersRepo.getUsers().then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setUsersList(ApiResponse.error(error.toString())));
  }

 */



}







