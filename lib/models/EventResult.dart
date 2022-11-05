import 'dart:core';

import 'package:flutter/material.dart';

class EventResult {
  String? id = "empty";
  String? codi = "";
  String? dataInici = "empty";
  String? dataIniciHora = "empty";
  String? dataFi;
  String? dataFiHora = "empty";
  String? dataFiAprox = "";
  String? dataFiAproxHora = "empty";
  String? denominacio = "NO_NAME";
  String? descripcio;
  String? entrades = "";
  String? horari = "";
  String? subtitol = "";
  List<String>? tagsAmbits;
  List<String>? tagsAmbitsCateg;
  List<String>? tagsAltresCateg;
  String? links = "";
  String? documents = "";
  String? imatges = "";
  String? videos = "";
  String? adreca = "";
  String? codiPostal = "";
  String? comarcaIMunicipi = "comarca/municipi: no info";
  String? email = "";
  String? latitud = "";
  String? localitat = "localitat: no info";
  String? longitud = "";


  EventResult({
    this.id,
    this.codi,
    this.denominacio,
    this.dataInici,
    this.dataIniciHora,
    this.dataFi,
    this.dataFiHora,
    this.dataFiAprox,
    this.dataFiAproxHora,
    this.links,
    this.documents,
    this.imatges,
    this.videos,
    this.adreca,
    this.codiPostal,
    this.comarcaIMunicipi,
    this.email,
    this.latitud,
    this.localitat,
    this.longitud,
    this.descripcio
  });

  EventResult.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    codi = json['codi'].toString();
    dataInici = dataAdapt(json['dataInici']);
    dataIniciHora = horaAdapt(json['dataInici']);
    dataFi = dataAdapt(json['dataFi']);
    denominacio = json['denominacio'];
    dataFiAprox = json['dataFiAprox'];
    descripcio = json['descripcio'];
    if(json['comarcaIMunicipi'] != null) comarcaIMunicipi = comarcaIMunicipiAdapt(json['comarcaIMunicipi']);
    else comarcaIMunicipi = json['comarcaIMunicipi'];
    debugPrint("comarcaIMunicipi és: $comarcaIMunicipi");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result =
    <String, dynamic>{};
    result['id'] = id;
    result['denominacio'] = denominacio;
    result['dataInici'] = dataInici;
    result['dataFi'] = dataFi;
    result['descripcio'] = descripcio;
    return result;
  }
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