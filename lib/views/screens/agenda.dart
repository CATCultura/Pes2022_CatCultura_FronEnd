import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Agenda extends StatelessWidget {
  const Agenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        backgroundColor: MyColorsPalette.lightBlue,
      ),
      backgroundColor: MyColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: const MyDrawer("Agenda",username:"Superjuane", email:"juaneolivan@gmail.com"),
      body: Container(
        color: MyColors.warning,
      ),
    );
  }
}