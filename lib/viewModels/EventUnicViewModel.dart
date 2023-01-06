import 'dart:io';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/ReviewResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/repository/EventsRepository.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../utils/Session.dart';

//imports per compartir esdeveniment
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//imports per google calendar
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as GCalendar;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EventUnicViewModel with ChangeNotifier {
  final _eventsRepo = EventsRepository();
  final session = Session();
  ApiResponse<EventResult> eventSelected = ApiResponse.loading();
  ApiResponse<EventResult> event = ApiResponse.loading();
  bool favorit = false, agenda = false;

  ApiResponse<String> addFavouriteResult = ApiResponse.loading();
  ApiResponse<String> addAttendanceResult = ApiResponse.loading();

  ApiResponse<List<ReviewResult>> reviews = ApiResponse.loading();

  final sessio = Session();


  bool waiting = true;


  String usernameSessio() {
    if(sessio.get("username") == null) return "2";
    return sessio.get("username");
  }

  String passwordSessio() {
    if(sessio.get("password") == null) return "2";
    return sessio.get("password");
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

  Future<AccessCredentials> obtainCredentials(var _scopes) async {
    final client = http.Client();
    print(_scopes);

    print("allo era el scope");
    try {
      return await obtainAccessCredentialsViaUserConsent(
        ClientId('612365228212-mscjcj8d8m8ga4hosroetl32lklgm208.apps.googleusercontent.com', ''),
        _scopes,
        client,
        _prompt,
      );
    } finally {
      client.close();
    }
  }

  void _prompt(String url) {
    print('Please go to the following URL and grant access:');
    print('  => $url');
    print('');
  }

  Future<void> addEventToGoogleCalendar(var _scopes, var titolEvent, var startTime)async{
    var _credentials;
    if(Platform.isAndroid){
      _credentials = new ClientId("612365228212-mscjcj8d8m8ga4hosroetl32lklgm208.apps.googleusercontent.com","");
    }
    else if(Platform.isIOS){
      _credentials = new ClientId("612365228212-tigv3ubogsu0fnmscboqtuofp5feqq0m.apps.googleusercontent.com","");
    }
    /*final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
      'OAuth Client ID',
      scopes: <String>[
        _scopes,
      ],
    );*/
    DateTime dateTime = DateFormat("d-M-yyyy").parse(startTime);
    GCalendar.Event event = GCalendar.Event();
    event.description = titolEvent;
    GCalendar.EventDateTime eventStartTime = new GCalendar.EventDateTime();
    eventStartTime.date = dateTime;
    //eventStartTime.date = startTime;
    eventStartTime.timeZone = "UTC+01:00";
    event.start = eventStartTime;
    insertarEvent(event, _credentials, _scopes);
  }


  Future<void> insertarEvent(var event, var _credentials, var _scopes) async {
    clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client) async {
      var calendar = GCalendar.CalendarApi(client);
      String calendarId = "primary";
      calendar.events.insert(event, calendarId).then((value){
        print("ADDEDDD___________${value.status}");
        if(value.status == "confirmed"){
          print('Event added in gogle calendar');
        }
        else{
          print("Unable to add event in google calendar");
        }
      });
    });
  }

  /*Future<void> insertarEvent(var event, var _credentials, var _scopes) async {
    try{
      clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client){
        var calendar = GCalendar.CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event, calendarId).then((value){
          print("ADDEDDD___________${value.status}");
          if(value.status == "confirmed"){
            print('Event added in gogle calendar');
          }
          else{
            print("Unable to add event in google calendar");
          }
        });
      });
    }
    catch (e){
      print('Error creating event $e');
    }
  }*/

  void prompt (String url) async {
    if(1 == 1/*await canLaunchUrlString(url)*/){
      await launchUrlString(url);
    }
    else {
      throw 'could not launch $url';
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
}