import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/repository/EventsRepository.dart';

class TagsViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  ApiResponse<List<String>> tagsList = ApiResponse.loading();

  setTagsList(ApiResponse<List<String>> response){
    debugPrint(response.toString());
    tagsList = response;
    notifyListeners();
  }

  Future<void> fetchTagsListApi() async {
    await _eventsRepo.getTags().then((value) {
      setTagsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setTagsList(ApiResponse.error(error.toString())));
  }
}