class RutaCulturalArgs {
  final double longitud;
  final double latitud;
  final int radio;
  final String data;

  RutaCulturalArgs(this.longitud, this.latitud, this.radio, this.data);
}

class RutaCulturalSaveArgs{
  String? name = "NO_NAME";
  String? description = "NO_DESRIPTION";
  bool? canceled = true;

  RutaCulturalSaveArgs(this.name, this.description, this.canceled);
}