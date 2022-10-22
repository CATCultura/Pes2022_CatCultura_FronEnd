import 'dart:core';

class UserResult {
  int ? id	= 0;
  String ? username = "empty";
  String ? nameAndSurname	= "empty";
  String ? email = "empty";
  /*
  password	string
  creationDate	string
  points	integer($int32)
  favourites	[Event{...}]
  trophies	[Trophy{...}]
  hiAssistire	[Event{...}]

   */

  UserResult({
    this.id,
    this.username,
    this.nameAndSurname,
    this.email
  });

  UserResult.fromJson(Map<String, dynamic> json) {
    id = json['id'].toint();
    username = json['id'].toString();
    nameAndSurname = json['id'].toString();
    email = json['id'].toString();
  }
/*
  Map<String, dynamic> toJson() {
    return
  }
 */
}