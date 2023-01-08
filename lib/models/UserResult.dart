import 'dart:core';

class UserResult {
  String ? id	= "empty";
  String ? username = "empty";
  String ? nameAndSurname	= "empty";
  String ? email = "empty";
  String ? creationDate;
  String ? role;
  String ? password = "empty";
  String ? points = "empty";
  List<String> ? tags = ["empty"];

  UserResult({
    this.id,
    this.username,
    this.nameAndSurname,
    this.email,
    this.creationDate,
    this.role,
    this.password,
    this.points,
    this.tags,
  });

  UserResult.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    username = json['username'].toString();
    nameAndSurname = json['nameAndSurname'].toString();
    email = json['email'].toString();
    creationDate = json['creationDate'].toString();
    role = json['role'].toString();
    points = json['points'].toString();
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "nameAndSurname": this.nameAndSurname,
      "username": this.username,
      "email": this.email,
      "creationDate": this.creationDate,
      // "role": this.role,
      "password": this.password,
      "points": this.points,
      "tags": this.tags,
    };
    return result;
  }
}