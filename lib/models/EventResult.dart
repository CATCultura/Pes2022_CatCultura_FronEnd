import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

class EventResult {
  String? id = "empty";
  String? codi = "";
  String? dataInici = "empty";
  //String? dataIniciHora = "empty";
  String? dataFi = "empty";
  //String? dataFiHora = "empty";
  String? dataFiAprox = "";
  //String? dataFiAproxHora = "empty";
  String? denominacio = "NO_NAME";
  String? descripcio = "NO DESCRIPTION AVAILABLE";
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
  String? espai = "espai: no info";
  double? latitud = 0.0;
  String? localitat = "localitat: no info";
  double? longitud = 0.0;
  String? telf = "";
  String? URL = "";
  String? ubicacio = "ubicacio: no info";
  String? imgApp = "";
  bool? cancelado = false;
  String? nomOrganitzador;
  int? idOrganitzador;
  String? urlOrganitzador;
  String? telefonOrganitzador;
  String? emailOrganitzador;



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
    this.cancelado,
    this.nomOrganitzador,
    this.idOrganitzador,
    this.urlOrganitzador,
    this.telefonOrganitzador,
    this.emailOrganitzador
  });

  EventResult.fromJson(Map<String, dynamic> jsonResponse) {
    id = jsonResponse['id'].toString();
    codi = jsonResponse['codi'].toString();
    dataInici = dataAdapt(jsonResponse['dataInici']);
    //dataIniciHora = horaAdapt(jsonResponse['dataInici']);
    dataFi = dataAdapt(jsonResponse['dataFi']);
    denominacio = jsonResponse['denominacio'];
    dataFiAprox = jsonResponse['dataFiAprox'];
    if(jsonResponse['descripcio'] != null) {
      descripcio = formatText(jsonResponse['descripcio']);
    } else {
      descripcio = "No descripcio";
    }
    // if(jsonResponse['comarcaIMunicipi'] != null) comarcaIMunicipi = comarcaIMunicipiAdapt(jsonResponse['comarcaIMunicipi']);
    // else comarcaIMunicipi = "comarca/municipi: no info";//json['comarcaIMunicipi'];
    comarcaIMunicipi = jsonResponse['ubicacio'];
    ubicacio = jsonResponse['ubicacio'];
    latitud = jsonResponse['latitud'];
    longitud = jsonResponse['longitud'];
    horari = jsonResponse['horaris'] ?? "No info sobre horaris";
    entrades = jsonResponse['entrades'] ?? "No info sobre entrades";
    if(jsonResponse['imatges'] != null) {
      imatges = (jsonResponse['imatges'] as List).map((item) => item as String).toList();
    }else{
      imatges = [];
    }
    if(jsonResponse['tagsAmbits'] != null) {
      tagsAmbits = (jsonResponse['tagsAmbits'] as List).map((item) => item as String).toList();
    }else{
      tagsAmbits = [];
    }
    if(jsonResponse['tagsAmbitsCateg'] != null) {
      tagsCateg = (jsonResponse['tagsAmbitsCateg'] as List).map((item) => item as String).toList();
    }else{
      tagsCateg = [];
    }
    if(jsonResponse['tagsAltresCateg'] != null) {
      tagsAltresCateg = (jsonResponse['tagsAltresCateg'] as List).map((item) => item as String).toList();
    }else{
      tagsAltresCateg = [];
    }

    //imatges = List<String>.from(json.decode(jsonResponse['imatges']));
    // Iterable l = json.decode(json['imatges']);
    // imatges = List<String?>.from(l.map((model)=> String.fromJson(model)));
    // imatges = List.from(json['imatges'].map(e) => e.toString().toList);
    // List<EventResult> res = List.from(response.map((e) => EventResult.fromJson(e)).toList());
    imgApp = jsonResponse['imgApp'];
    espai = jsonResponse['espai'];
    adreca = jsonResponse['adreca'];
    //if(jsonResponse['espai'] == null || jsonResponse['espai'] == "") espai = "espai";
    cancelado = jsonResponse['cancelado'];
    nomOrganitzador = jsonResponse['nomOrganitzador'] ?? "Organitzador anònim";
    idOrganitzador = jsonResponse['idOrganitzador'] ?? -1;
    urlOrganitzador = jsonResponse['urlOrganitzador'] ?? "";
    telefonOrganitzador = jsonResponse['telefonOrganitzador'] ?? "";
    emailOrganitzador = jsonResponse['emailOrganitzador'] ?? "";


  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> result = [
      {'id': id, 'codi': codi, 'denominacio': denominacio, 'dataInici': dataInici,
      'dataFi': dataFi, 'ubicacio': ubicacio, 'adreca': adreca, 'espai': espai, 'cancelado': cancelado,
        'dataFi': dataFi, 'ubicacio': ubicacio, 'adreca': adreca, 'espai': espai, 'cancelado': cancelado,
        'descripcio': descripcio, 'latitud': latitud, 'longitud': longitud, 'dataFiAprox': dataFiAprox,
        'entrades': entrades, 'horari': horari, 'subtitol': subtitol, 'links': links, 'documents': documents,
        'videos': videos, 'codiPostal': codiPostal, 'email': email, 'telf': telf, 'URL': URL, 'imgApp': imgApp,
        'tagsAmbits': tagsAmbits, 'tagsCateg': tagsCateg, 'tagsAltresCateg': tagsAltresCateg, 'imatges': imatges }
    ];
    return result;
  }
}

String formatText(String s) {
  String aux = s.replaceAll ("&nbsp;", " ");
  aux = aux.replaceAll ("nbsp;", "");
  aux = aux.replaceAll ("&amp;", "&");
  aux = aux.replaceAll ("amp;", "&");

  return aux;
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