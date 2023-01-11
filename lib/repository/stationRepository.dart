import 'package:flutter/material.dart';

import '../data/network/networkApiServices.dart';
import '../models/StationResult.dart';

class StationRepository {
  // final baseUrl = "http://40.113.160.200:8081/";
  final baseUrl = "http://15.188.52.76:3000/api/v2/";
  final NetworkApiServices _apiServices = NetworkApiServices();
  // final session = Session();

  StationRepository._privateConstructor();

  static final StationRepository _instance = StationRepository
      ._privateConstructor();

  factory StationRepository() {
    return _instance;
  }


  Future<List<StationResult>> getStations(int radius, double latitud, double longitud) async {
    try {
      dynamic response;
      response = await _apiServices.getGetApiResponse("${baseUrl}estaciones?distancia=$radius&latitud=$latitud&longitud=$longitud"); //40.113.160.200:8081
      // if(response == null )response = [
      //   {
      //     "id": "550e8400-e29b-41d4-a716-446655440000",
      //     "direccion": "Avinguda Meridiana, 66",
      //     "codiProv": "08",
      //     "latitud": "41.74441",
      //     "longitud": "2.18729",
      //     "municipio": "Barcelona",
      //     "nPlaces": 3,
      //     "potencia": 22,
      //     "promotor": "Generalitat de Catalunya",
      //     "provincia": "Barcelona",
      //     "tipoConexion": "2xMENNEKES.F",
      //     "tipoCorriente": "AC",
      //     "tipoVehiculo": "cotxe i moto",
      //     "tipoVelocidad": "semiRAPID"
      //   }
      // ];
      debugPrint(response.toString());
      if(response.isNotEmpty){
        return response.map<StationResult>((json) => StationResult.fromJson(json)).toList();
      }else{
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}