import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventInfoRoundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'This is a Container',
        textScaleFactor: 2,
        style: TextStyle(color: Colors.black),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),
      ),
      height: 50,
    );
  }
}
