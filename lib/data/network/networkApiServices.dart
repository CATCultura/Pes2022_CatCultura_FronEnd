import 'dart:convert';
import 'dart:io';
import 'package:CatCultura/data/appExceptions.dart';
import 'package:CatCultura/data/network/baseApiServices.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson, responseJsonMock;
  @override
  Future getGetApiResponse(String url) async {
    //String mockedURL ="http://127.0.0.1:5001/get-all";
    //String mockedURL = 'https://jsonplaceholder.typicode.com/albums/1';
    //String url = "http://10.4.41.41:8081/event/id=8";

    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
      //debugPrint(responseJson.toString());

      //const jsonMock = '''{"results":[{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName9", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName10", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName11", "dataInici": "01/01/9999", "dataFi":"01/01/9999"}]}''';
      //responseJsonMock = jsonDecode(jsonMock);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data.toJson()),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br', 'Host': '10.4.41.41:8081', 'Content-Length': utf8.encode(jsonEncode(data)).length.toString()},
      ).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 60));
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
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        //dynamic responseJson = jsonDecode(response.body);

        final codeUnits = response.body.codeUnits;
        String text = const Utf8Decoder().convert(codeUnits);
        dynamic res = jsonDecode(text);
        return res;
      case 201:
        return response.body;
      case 400:
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
