import 'dart:convert';
import 'dart:io';
import 'package:tryproject2/data/appExceptions.dart';
import 'package:tryproject2/data/network/baseApiServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson, responseJsonMock;
  @override
  Future getGetApiResponse(http.Client client) async {
    //String mockedURL ="http://127.0.0.1:5001/get-all";
    String mockedURL = 'https://jsonplaceholder.typicode.com/albums/1';
    String url = "http://10.4.41.41:8081/events";
    try {
      print("aqui");
      final response = await client.get(Uri.parse(mockedURL));
      print("aqui2");
      responseJson = returnResponse(response);
      debugPrint(response.body.toString() +"\n -----jsonplaceholder-----\n-----mockedJson-----");
      /*nom,
    this.dataIni,
    this.dataFi,
    this.lloc,
    this.comarcaMunicipi,
    this.descripcio*/
      const jsonMock = '''{"results":[{ "nom": "mockedName1", "dataIni": "01/01/9999", "dataFi":"01/01/9999"}]}''';
      responseJsonMock = jsonDecode(jsonMock);
      debugPrint(jsonMock.toString());

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJsonMock;
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
        dynamic responseJson = jsonDecode(response.body);
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