import 'package:intl/intl.dart';


class EventContainerViewModel{
  //De moment guardo info de un sol event
  String get NomEvent => "Event d'Exemple ";
  DateFormat formatter = DateFormat('dd-MM-yyyy   H:mm');
  String get dataInici => formatter.format(DateTime(2022, 10, 3, 10, 00));
  String get dataFi => formatter.format(DateTime(2022, 10, 4, 12, 30));
  String get img => "https://static.comunicae.com/photos/notas/1206347/1562921272_02_Eventoplus_Eventodays2019_Feria_131.jpg";
  get lat => 41.6512425;
  get long => 2.135203899999965;
  String get espai => "EspaiEvent Exemple";
  String get ComarcaMunicipi => "ComarcaExemple";
  get tel => 977401149;
  get url => "https://URLdeProva.com";
  String get description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
}