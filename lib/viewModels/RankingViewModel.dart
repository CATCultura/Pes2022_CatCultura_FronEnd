import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/UserResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';

import '../utils/Session.dart';



class RankingViewModel with ChangeNotifier {
  final _usersRepo = UsersRepository();

  ApiResponse<UserResult> mainUser = ApiResponse.loading();
  List<UserResult> users = [];
  var finish = false;

  final Session sessio = Session();

  setMainUserSelected(ApiResponse<UserResult> response) {
    mainUser = response;
    notifyListeners();
  }

  Future<void> selectUserById(String id) async {
    await _usersRepo.getUserById(id).then((value) {
      setMainUserSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setMainUserSelected(ApiResponse.error(error.toString())));
  }

  Future<void> iniRanking()async {
    await selectUserById(sessio.data.id.toString());
    await mainUser.status == Status.COMPLETED ? users.add(mainUser.data!):Text("a");
    for (var i = 0; i < sessio.data.friendsId!.length; ++i){
      await selectUserById(sessio.data.friendsId![i].toString());
      await mainUser.status == Status.COMPLETED ? users.add(mainUser.data!):Text("a");
      //users.add(mainUser.data!);
    }
    users.sort((a, b) => b.points!.compareTo(a.points!));
    mainUser.status == Status.COMPLETED ? finish = true:Text("a");
    notifyListeners();
  }


}