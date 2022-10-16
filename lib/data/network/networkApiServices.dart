import 'dart:convert';
import 'dart:io';
import 'package:tryproject2/data/appExceptions.dart';
import 'package:tryproject2/data/network/baseApiServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson, responseJsonMock;
  @override
  Future getGetApiResponse(String url) async {
    //String mockedURL ="http://127.0.0.1:5001/get-all";
    String mockedURL = 'https://jsonplaceholder.typicode.com/albums/1';
    String url = "http://10.4.41.41:8081/event/id=8";

    try {
      print("aqui");
      final response = await http.get(Uri.parse(url));
      print("aqui2");
      debugPrint(response.body);
      responseJson = returnResponse(response);
      //debugPrint(responseJson.toString());
      //debugPrint(response.body.length.toString() + response.body.toString()  +"\n -----jsonplaceholder-----\n-----mockedJson-----");

      //const jsonMock = '''{"results":[{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName1", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName9", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName10", "dataInici": "01/01/9999", "dataFi":"01/01/9999"},{ "id": "mockedName11", "dataInici": "01/01/9999", "dataFi":"01/01/9999"}]}''';
      //responseJsonMock = jsonDecode(jsonMock);
      //debugPrint("networkApiServices harcoded: " + jsonMock.toString());
      debugPrint("networkApiServices petition: " + responseJson.toString());

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
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
      String aux;
      if(response.body.toString()[0] == '[') aux = "{\"results\":" + response.body.toString() + "}";
      else aux = "{\"results\":[" + response.body.toString() + "]}";
        dynamic responseJson =jsonDecode(aux);
        return responseJson;
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