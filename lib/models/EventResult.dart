import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

class EventResult {
  String? id = "empty";
  String? codi = "";
  String? dataInici = "empty";
  //String? dataIniciHora = "empty";
  String? dataFi;
  //String? dataFiHora = "empty";
  String? dataFiAprox = "";
  //String? dataFiAproxHora = "empty";
  String? denominacio = "NO_NAME";
  String? descripcio;
  String? entrades = "";
  String? horari = "";
  String? subtitol = "";
  List<String>? tagsAmbits;
  List<String>? tagsCateg;
  List<String>? tagsAltresCateg;
  String? links = "";
  String? documents = "";
  List<String>? imatges = [];
  String? videos = "";
  String? adreca = "";
  String? codiPostal = "";
  String? comarcaIMunicipi = "comarca/municipi: no info";
  String? email = "";
  String? espai = "";
  double? latitud = 0.0;
  String? localitat = "localitat: no info";
  double? longitud = 0.0;
  String? telf = "";
  String? URL = "";
  String? ubicacio = "";
  String? imgApp = "";
  //bool cancelado = false;


  EventResult({
    this.id,
    this.codi,
    this.denominacio,
    this.dataInici,
    //this.dataIniciHora,
    this.dataFi,
    //this.dataFiHora,
    this.dataFiAprox,
    //this.dataFiAproxHora,
    this.links,
    this.documents,
    this.imatges = const [""],
    this.videos,
    this.adreca,
    this.codiPostal,
    this.comarcaIMunicipi,
    this.email,
    this.latitud,
    this.localitat,
    this.longitud,
    this.descripcio,
    this.entrades,
    this.horari,
    this.subtitol,
    this.tagsAmbits,
    this.tagsCateg,
    this.tagsAltresCateg,
    this.espai,
    this.telf,
    this.URL,
    this.ubicacio,
    this.imgApp,
    //this.cancelado
  });

  EventResult.fromJson(Map<String, dynamic> jsonResponse) {
    id = jsonResponse['id'].toString();
    codi = jsonResponse['codi'].toString();
    dataInici = dataAdapt(jsonResponse['dataInici']);
    //dataIniciHora = horaAdapt(jsonResponse['dataInici']);
    dataFi = dataAdapt(jsonResponse['dataFi']);
    denominacio = jsonResponse['denominacio'];
    dataFiAprox = jsonResponse['dataFiAprox'];
    descripcio = jsonResponse['descripcio'];
    if(jsonResponse['comarcaIMunicipi'] != null) comarcaIMunicipi = comarcaIMunicipiAdapt(jsonResponse['comarcaIMunicipi']);
    else comarcaIMunicipi = "comarca/municipi: no info";//json['comarcaIMunicipi'];
    latitud = jsonResponse['latitud'];
    longitud = jsonResponse['longitud'];
    imatges = (jsonResponse['imatges'] as List).map((item) => item as String).toList();
    //imatges = List<String>.from(json.decode(jsonResponse['imatges']));
    // Iterable l = json.decode(json['imatges']);
    // imatges = List<String?>.from(l.map((model)=> String.fromJson(model)));
    // imatges = List.from(json['imatges'].map(e) => e.toString().toList);
    // List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());

  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'id': id, 'codi': codi, 'denominacio': denominacio, 'dataInici': dataInici,
      'dataFi': dataFi, 'ubicacio': ubicacio, 'adreca': adreca, 'espai': espai}
    ];
    return result;
  }

  /** Map<String, dynamic> toJson() {
    final Map<String, dynamic> result =
    <String, dynamic>{};
    result['id'] = id;
    result['denominacio'] = denominacio;
    result['dataInici'] = dataInici;
    result['dataFi'] = dataFi;
    result['descripcio'] = descripcio;
    return result;
  } **/
}


String? comarcaIMunicipiAdapt(String s) {
  String res = "";
  int numberSlashs = 0;
  for (int i = 0; i < s.length; ++i) {
    if (s[i] == '/') {
      ++numberSlashs;
      if (numberSlashs == 3) res += ' - ';
    }
    else if (numberSlashs >= 2) {
      res += s[i];
    }
  }
  return res;
}

String? horaAdapt(String string) {

}

String? dataAdapt(String s) {
  String res = s[8]+s[9]+'-';
  res += s[5]+s[6]+'-';
  res += s[0]+s[1]+s[2]+s[3];
  return res;
}