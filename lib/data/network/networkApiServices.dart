import 'dart:convert';
import 'dart:io';
import 'package:CatCultura/data/appExceptions.dart';
import 'package:CatCultura/data/network/baseApiServices.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/Session.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson, responseJsonMock;
  final session = Session();

  @override
  Future getGetApiResponse(String url) async {
    //String mockedURL ="http://127.0.0.1:5001/get-all";
    //String mockedURL = 'https://jsonplaceholder.typicode.com/albums/1';
    //String url = "http://10.4.41.41:8081/event/id=8";

    try {
      // final pass = Session().get("auth") == null ? "hola" : Session().get("auth");
      //final response = await http.get(Uri.parse(url), headers: {"Authorization":pass});
      //responseJson = returnResponse(response);
      //debugPrint(responseJson.toString());
      final Codec<String, String> stringToBase64 = utf8.fuse(base64);
      late String encoded = stringToBase64.encode("admin:admin");
      late String auth = "Basic $encoded";

      final response;
      if (session.get('authorization') != null) {
        debugPrint("authorized");
        response = await http.get(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json',
            // 'Authorization': session.get('authorization'),},
            'Authorization': session.get('authorization'),},
        ).timeout(const Duration(seconds: 10));

      }
      else{
        debugPrint("not authorized");
        response = await http.get(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
        ).timeout(const Duration(seconds: 10));
      }
      responseJson = returnResponse(response);

      // debugPrint(responseJson.toString());
      //const jsonMock = '''{"results":[{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName9", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName10", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName11", "dataInici": "01/01/9999", "dataFi":"01/01/9999"}]}''';
      //responseJsonMock = jsonDecode(jsonMock);


    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    //debugPrint("response json desde network api: $responseJson");
    return responseJson;
  }




  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response;
      if (session.get('authorization') != null) {
        debugPrint("auth: " + session.get('authorization').toString());
        response = await http.post(
          Uri.parse(url),
          // body: jsonEncode(data.toJson()),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',

            'Authorization': session.get('authorization')
          ?? ""},
        ).timeout(const Duration(seconds: 10));
      }
      else {
        debugPrint("not authorized");
        response = await http.post(
          Uri.parse(url),
          // body: jsonEncode(data.toJson()),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Host': '10.4.41.41:8081',
            'Content-Length': utf8
                .encode(jsonEncode(data))
                .length
                .toString(),
          },
        ).timeout(const Duration(seconds: 10));
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    var httpClient = http.Client();
    try {

      /*
        Uri url = Uri.tryParse("https://ptsv2.com/t/umt4a-1569012506/post");
        http.Request request = new http.Request("post", url);
        request.headers.clear();
        request.headers.addAll({"content-type":"application/json; charset=utf-8"});
        request.body = '{mediaItemID: 04b568fa, uri: https://www.google.com}';
        var letsGo = await request.send();
       */
      // http.Request request = new http.Request("put", Uri.parse(url));
      // request.body = jsonEncode(data);
      // request.headers.clear();
      // request.headers.addAll({'Content-Type': 'application/json'});
      // if (session.get('authorization') != null) {
      //   request.headers.addAll({'Authorization': session.get('authorization')});
      // }
      final response;
      if (session.get('authorization') != null) {
        response = await http.put(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json',
            'Authorization': session.get('authorization'),},
        ).timeout(const Duration(seconds: 10));
      }
      else{
        response = await http.put(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json',},
        ).timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPutEventApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    List<Map<String, dynamic>> aux = data.toJson();
    Map<String, dynamic> content = <String, dynamic>{};
    for (int i = 0; i < 1; ++i) {
      content = aux[i];
      print(aux[i]);
    }

    print("el tamany de aux es: ");
    print(aux.length);

    print("el tamany de content es: ");
    print(content.length);
    print(content);

    try {

      http.Response response;
      if (session.get('authorization') != null) {
        response = await http.put(
          Uri.parse(url),
          body: jsonEncode(content),
          headers: {'Content-Type': 'application/json',
            'Authorization': session.get('authorization'),},
        ).timeout(const Duration(seconds: 10));
      }
      else{
        response = await http.put(
          Uri.parse(url),
          body: jsonEncode(content),
          headers: {'Content-Type': 'application/json',},
        ).timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url, dynamic data) async{
    dynamic responseJson;

    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json',
          'Authorization': session.get('authorization'),},
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final codeUnits = response.body.codeUnits;
        String text = const Utf8Decoder().convert(codeUnits);
        dynamic res = jsonDecode(text);
        return res;
      case 201:
        final codeUnits = response.body.codeUnits;
        String text = const Utf8Decoder().convert(codeUnits);
        dynamic res = jsonDecode(text);
        debugPrint("from networkApiServices printing response on code 201:\n$res\n");
        return res;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        debugPrint("from networkApiServices printing response on code 401");
        //throw BadRequestException(response.body.toString());
          throw UnauthorisedException(response.body.toString());
      case 403:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            "Error accourded while communicating with server with status code ${response.statusCode}");
    }
  }
}