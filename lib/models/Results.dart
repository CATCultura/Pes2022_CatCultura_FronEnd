import 'dart:core';

class Results {
  String? id = "empty";
  String? denominacio = "asdads";
  String? dataInici = "empty";
  String? dataFi;
  String? lloc;
  String? comarcaMunicipi;
  String? descripcio;


  Results({
    this.id,
    this.denominacio,
    this.dataInici,
    this.dataFi,
    this.lloc,
    this.comarcaMunicipi,
    this.descripcio
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    dataInici = json['dataInici'];
    dataFi = json['dataFi'];
    denominacio = json['denominacio'];
    //lloc = json['lloc'];
    //comarcaMunicipi = json['comarcaMunicipi'];
    //descripcio = json['descripcio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result =
    <String, dynamic>{};
    result['id'] = id;
    result['denominacio'] = denominacio;
    result['dataInici'] = dataInici;
    result['dataFi'] = dataFi;
    result['lloc'] = lloc;
    result['comarcaMunicipi'] = comarcaMunicipi;
    result['descripcio'] = descripcio;
    return result;
  }
}