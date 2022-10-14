import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

class attributes extends StatelessWidget {
  final String attribute;
  attributes(this.attribute);

  @override
  Widget build(BuildContext context) {
    print(attribute);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: attribute,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 3
              ),
            ),
          ),
        ),
      ),
    );
  }
}