import 'dart:core';

class TrophyResult {
  String ? id = "empty";
  String ? name = "empty";
  String ? points = "empty";
  String ? description = "empty";


  TrophyResult({
    this.id,
    this.name,
    this.points,
    this.description
  });

  TrophyResult.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['username'].toString();
    points = json['points'].toString();
    description = json['points'].toString();
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "id": this.id,
      "name": this.name,
      "points": this.points,
      "description": this.description
    };
    return result;
  }
}