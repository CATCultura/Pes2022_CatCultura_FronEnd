import 'dart:core';

class UserResult {
  int ? id	= 0;
  String ? username = "manolitoklk";
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
    this.email,
    this.password
  });

  UserResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'].toString();
    nameAndSurname = json['nameAndSurname'].toString();
    email = json['email'].toString();
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "nameAndSurname": this.nameAndSurname,
      "username": this.username,
      "email": this.email,
      "password": this.password
    };
    return result;
  }
 */
}