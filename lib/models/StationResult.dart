class StationResult {
  String? id;
  String? direccion;
  String? codiProv;
  double? latitud;
  double? longitud;
  String? municipio;
  int? nPlaces;
  int? potencia;
  String? promotor;
  String? provincia;
  String? tipoConexion;
  String? tipoCorrient;
  String? tipoVehiculo;
  String? tipoVelocidad;

  StationResult({
    this.id,
    this.direccion,
    this.codiProv,
    this.latitud,
    this.longitud,
    this.municipio,
    this.nPlaces,
    this.potencia,
    this.promotor,
    this.provincia,
    this.tipoConexion,
    this.tipoCorrient,
    this.tipoVehiculo,
    this.tipoVelocidad,
  });

  StationResult.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 'noId';
    direccion = json['direccion'] ?? 'noDireccion';
    // codiProv = json['codiProv'] ?? 'noCodiProv';
    latitud = json['latitud']?? 0.0;
    longitud = json['longitud']?? 0.0;
    municipio = json['municipio'] ?? '';
    // nPlaces = json['nPlazas'] ?? 0;
    // potencia = json['potencia'] ?? 0;
    promotor = json['promotor'] ?? '';
    provincia = json['provincia'] ?? '';
    tipoConexion = json['tipoConexion'] ?? '';
    tipoCorrient = json['tipoCorrient'] ?? '';
    tipoVehiculo = json['tipoVehiculo'] ?? '';
    tipoVelocidad = json['tipoVelocidad'] ?? '';
  }


}