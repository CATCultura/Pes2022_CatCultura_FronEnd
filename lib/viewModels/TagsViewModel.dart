import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/UsersRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'dart:convert';
import '../models/UserResult.dart';
import '../utils/Session.dart';


class TagsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final _usersRepo = UsersRepository();
  ApiResponse<List<String>> tagsList = ApiResponse.loading();

  setTagsList(ApiResponse<List<String>> response){
    debugPrint(response.toString());
    tagsList = response;
    notifyListeners();
  }

  setTags(ApiResponse<String> response){
    //debugPrint(response.toString());
    notifyListeners();
  }

  Future<void> fetchTagsListApi() async {
    await _eventsRepo.getTags().then((value) {
      setTagsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setTagsList(ApiResponse.error(error.toString())));
  }

  Future<void> editUserTags(List<String> tags) async {
    await _usersRepo.postCreaTags(Session().data.id.toString(), tags).then((value) {
      setTags(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setTags(ApiResponse.error(error.toString())));
  }

  void dispose() {}
}
