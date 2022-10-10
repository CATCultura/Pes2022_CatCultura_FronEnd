import 'dart:core';

class Results {
  String? nom;
  String? dataIni;
  String? dataFi;
  String? lloc;
  String? comarcaMunicipi;
  String? descripcio;


  Results({
    this.nom,
    this.dataIni,
    this.dataFi,
    this.lloc,
    this.comarcaMunicipi,
    this.descripcio
  });

  Results.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    dataIni = json['dataIni'];
    dataFi = json['dataFi'];
    lloc = json['lloc'];
    comarcaMunicipi = json['comarcaMunicipi'];
    descripcio = json['descripcio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result =
    <String, dynamic>{};
    result['nom'] = nom;
    result['dataIni'] = dataIni;
    result['dataFi'] = dataFi;
    result['lloc'] = lloc;
    result['comarcaMunicipi'] = comarcaMunicipi;
    result['descripcio'] = descripcio;
    return result;
  }
}