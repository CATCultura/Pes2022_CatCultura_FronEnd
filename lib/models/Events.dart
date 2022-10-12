import 'package:flutter/material.dart';
import 'dart:core';

import 'package:tryproject2/models/Results.dart';

/*String get NomEvent => "Event d'Exemple ";
  DateFormat formatter = DateFormat('dd-MM-yyyy   H:mm');
  String get dataInici => formatter.format(DateTime(2022, 10, 3, 10, 00));
  String get dataFi => formatter.format(DateTime(2022, 10, 4, 12, 30));
  String get img => "https://static.comunicae.com/photos/notas/1206347/1562921272_02_Eventoplus_Eventodays2019_Feria_131.jpg";
  get lat => 41.6512425;
  get long => 2.135203899999965;
  String get espai => "123456789"/*0123456789012345678901234567890123456789012345"*/;
  String get ComarcaMunicipi => "ComarcaExemple"/* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"*/;
  get tel => 977401149;
  get url => "https://URLdeProva.com";
  String get description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quisque sagittis purus sit amet volutpat consequat. Rhoncus aenean vel elit scelerisque mauris. Eget magna fermentum iaculis eu. Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. Maecenas ultricies mi eget mauris pharetra et ultrices neque. Dolor purus non enim praesent elementum facilisis leo vel. Dis parturient montes nascetur ridiculus mus. Volutpat odio facilisis mauris sit amet. Nunc eget lorem dolor sed viverra ipsum. Morbi tristique senectus et netus et malesuada fames ac turpis. Amet porttitor eget dolor morbi non arcu risus. Dictum sit amet justo donec enim diam vulputate ut pharetra. A iaculis at erat pellentesque adipiscing commodo elit at imperdiet.Risus commodo viverra maecenas accumsan lacus vel. Ac tincidunt vitae semper quis lectus nulla at volutpat. Feugiat in ante metus dictum at tempor commodo ullamcorper. Ac tortor dignissim convallis aenean et tortor at. Adipiscing elit ut aliquam purus sit amet luctus venenatis lectus. Placerat vestibulum lectus mauris ultrices eros in cursus. Neque sodales ut etiam sit amet nisl purus in. Fermentum posuere urna nec tincidunt. Velit scelerisque in dictum non consectetur a erat nam at. Pretium nibh ipsum consequat nisl vel pretium lectus quam. Est ultricies integer quis auctor. Molestie at elementum eu facilisis sed. Amet tellus cras adipiscing enim eu turpis egestas. Eu augue ut lectus arcu. Suspendisse faucibus interdum posuere lorem ipsum dolor sit. Etiam tempor orci eu lobortis elementum. Et netus et malesuada fames ac turpis egestas sed. Volutpat sed cras ornare arcu.";
*/

class Events {
  List<Results>? results;

  Events.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
    <String, dynamic>{};

    if (results != null) {
      data['results'] = results!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }

}