import 'dart:ffi';
//import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/ReviewResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import '../utils/Session.dart';
//imports per compartir esdeveniment
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';



//imports per google calendar
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as GCalendar;
//import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class EventUnicViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final session = Session();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();
  ApiResponse<EventResult> event = ApiResponse.loading();
  bool favorit = false, agenda = false;

  late PermissionStatus camera;
  bool cameraActivated = false;

  ApiResponse<String> addFavouriteResult = ApiResponse.loading();
  ApiResponse<String> addAttendanceResult = ApiResponse.loading();

  ApiResponse<List<ReviewResult>> reviews = ApiResponse.loading();

  final sessio = Session();
  var isUser = false;
  var isAdmin = false;
  var isOrganizer = false;

  bool waiting = true;


  String usernameSessio() {
    if(sessio.get("username") == null) return "2";
    return sessio.get("username");
  }

  String passwordSessio() {
    if(sessio.get("password") == null) return "2";
    return sessio.get("password");
  }

  void ini(){
    if(sessio.data.id != -1){
      isUser = true;
      if(sessio.data.role == "ADMIN") isAdmin = true;
      if(sessio.data.role == "ORGANIZER") isOrganizer = true;
    }
  }

  setEventSelected(ApiResponse<EventResult> response){
    debugPrint("event selected with status: ${response.status}, id: ${response.data!.id} and title: ${response.data!.denominacio}\n and espai: ${response.data!.espai}");
    eventSelected = response;
    notifyListeners();
  }

  setEventResult(ApiResponse<EventResult> response) {
    event = response;
    notifyListeners();
  }

  setReviews(ApiResponse<List<ReviewResult>> response) {
    // for (var e in response.data!) {
    //   debugPrint(e.title);
    // }
    reviews = response;
    notifyListeners();
  }

  Future<void> selectEventById(String id) async{
    debugPrint("selecting event by id");
    if(sessio.data.favouritesId != null)favorit = session.data.favouritesId!.contains(int.parse(id));
    if(sessio.data.attendanceId != null)agenda = session.data.attendanceId!.contains(int.parse(id));
    debugPrint(favorit? "si en favorit": "no en favorit");
    debugPrint(agenda? "si en agenda": "no en agenda");
    await _eventsRepo.getEventById(id).then((value){
      setEventSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString())));
    await _eventsRepo.getEventReviewsById(id).then((value){
      setReviews(ApiResponse.completed(value));
    });
  }

  Future<void> getReviews() async {
    reviews.status = Status.LOADING;
    notifyListeners();
    await _eventsRepo.getEventReviewsById(eventSelected.data!.id!).then((value){
      setReviews(ApiResponse.completed(value));
    });
  }

  setFavouriteResult(ApiResponse<String> response){
    addFavouriteResult = response;
    favorit = !favorit;
    notifyListeners();
  }

  setAttendanceResult(ApiResponse<String> response) {
    addAttendanceResult = response;
    agenda = !agenda;
    notifyListeners();
  }

  Future<void> putFavouriteById(String userId, String? eventId) async{
    if(eventId != null) {
      await _eventsRepo.addFavouriteByUserId(session.data.id.toString(), int.parse(eventId)).then((value) {
        setFavouriteResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) =>
          setFavouriteResult(ApiResponse.error(error.toString())));
    }
  }

  Future<void> deleteFavouriteById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteFavouriteByUserId(session.data.id.toString(), int.parse(eventId)).then((value){
        setFavouriteResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setFavouriteResult(ApiResponse.error(error.toString())));
    }
  }

  Future<void> putAttendanceById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.addAttendanceByUserId(session.data.id.toString(), int.parse(eventId)).then((value){
        setAttendanceResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setAttendanceResult(ApiResponse.error(error.toString())));
    }
  }

  Future<void> deleteAttendanceById(String userId, String? eventId) async{
    if(eventId != null){
      await _eventsRepo.deleteAttendanceByUserId(session.data.id.toString(), int.parse(eventId)).then((value){
        setAttendanceResult(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setAttendanceResult(ApiResponse.error(error.toString())));
    }
  }

  shareEvent(var imgUrl, var titol) async {
    final url = Uri.parse(imgUrl);
    final response = await http.get(url);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path], text: titol);
  }

  shareQrImage(var titol, Uint8List qr) async {
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/qr.png';

    File(path).writeAsBytesSync(qr);
    await Share.shareFiles([path], text: titol);
  }

  Future<void> addEventToGoogleCalendar(var _scopes)async{
    var _credentials;
    if(Platform.isAndroid){
      _credentials = new ClientId('falta generar la ID');
    }
    else if(Platform.isIOS){
      _credentials = new ClientId('falta generar la ID');
    }


  }
  // @override
  // void dispose() {
  // }

  Future<void> deleteEventById(String? eventId) async{
    if(eventId != null){
      print(eventId);
      await _eventsRepo.deleteEventId(eventId).then((value){
        //setEventSelected(ApiResponse.completed(value));
      }).onError((error, stackTrace) => setEventSelected(ApiResponse.error(error.toString())));
    }
    waiting = false;
  }


  Future<void> putEventById(EventResult e) async {
    await _eventsRepo.addEventById(e); /** .then((value) {
      setEventSelected(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString()))); **/
    waiting = false;
  }

  Future<void> putCancelledEventById(String? eventId) async {
    await _eventsRepo.cancelledEventById(eventId); /** .then((value) {
        setEventSelected(ApiResponse.completed(value));
        }).onError((error, stackTrace) =>
        setEventSelected(ApiResponse.error(error.toString()))); **/
    waiting = false;
  }

  bool wrongCode = false;

  confirmAttendance(String text, String? eventId) async {
  debugPrint("here");
    await _eventsRepo.confirmAttendance(text,Session().data.id,eventId!).then((value) {
      if (value == "Bad code") {
        wrongCode = true;
      }
      notifyListeners();
    }).onError((error, stackTrace) => null);

  }

  setWrongCode(bool code) {
    wrongCode=code;
    notifyListeners();
  }

  requestPermission() async {
    if (await Permission.camera.isGranted) {
      cameraActivated=true;
      notifyListeners();
    }

  }

  setPermission(bool p) {
    notifyListeners();
  }

  ApiResponse<String> attendanceCode = ApiResponse.loading();

  void getAttendanceCode(String eventId) async {
    await _eventsRepo.getAttendanceCode(eventId).then((value)=>
    setAttendanceCode(ApiResponse.completed(value)));
  }

  setAttendanceCode(ApiResponse<String> apiResponse) {
    attendanceCode=apiResponse;
    notifyListeners();
  }
}