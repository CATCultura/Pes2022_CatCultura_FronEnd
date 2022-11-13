import 'package:flutter/material.dart';

Widget getSizedText(String s) {
  print(s.length);
  TextStyle t;
  if (s.length <= 54) {
    return Flexible(child: Text(s));
  } else {
    return Flexible(
        child: Text(
          s,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
