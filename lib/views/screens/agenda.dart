import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/eventContainerAgenda.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

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
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
          child: EventContainerAgenda(),
        ),
      ),
    );
  }
}