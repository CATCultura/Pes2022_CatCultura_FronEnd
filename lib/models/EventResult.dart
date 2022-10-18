import 'dart:core';

class EventResult {
  String? id = "empty";
  String? codi = "";
  String? dataInici = "empty";
  String? dataFi;
  String? dataFiAprox = "";
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
    this.dataFi,
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
    dataInici = json['dataInici'];
    dataFi = json['dataFi'];
    denominacio = json['denominacio'];
    dataFiAprox = json['dataFiAprox'];
    descripcio = json['descripcio'];
    // descripcio = ;
    // entrades =
    //     horari = ""
    // subtitol =
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