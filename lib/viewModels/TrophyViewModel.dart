import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/TrophyResult.dart';

import '../repository/TrophyRepository.dart';

class TrophyViewModel with ChangeNotifier{
  final _trophyRepo = TrophyRepository();

  ApiResponse<TrophyResult> unicTrophy = ApiResponse.loading();
  ApiResponse<List<TrophyResult>> trophies = ApiResponse.loading();
  ApiResponse<List<TrophyResult>> myTrophies = ApiResponse.loading();

  setTrpohySelected(ApiResponse<TrophyResult> response){
    unicTrophy = response;
    notifyListeners();
  }

  setTrophiesReceived(ApiResponse<List<TrophyResult>> response){
    print("before trophieslist = response (with exit)");
    debugPrint(response.toString());
    trophies = response;
    notifyListeners();
  }

  setMyTrophiesReceived(ApiResponse<List<TrophyResult>> response){
    print("before trophieslist = response (with exit)");
    debugPrint(response.toString());
    myTrophies = response;
    notifyListeners();
  }

  Future<void> receivedTrophies() async{
    await _trophyRepo.getTrophy().then((value){
      setTrophiesReceived(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setTrophiesReceived(ApiResponse.error(error.toString())));
  }

  Future<void> receivedMyTrophies(String id) async{
    await _trophyRepo.getMyTrophies(id).then((value){
      setMyTrophiesReceived(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setMyTrophiesReceived(ApiResponse.error(error.toString())));
  }

}