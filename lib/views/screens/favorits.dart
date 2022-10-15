import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';
import 'package:tryproject2/views/widgets/eventContainer.dart';

class Favorits extends StatelessWidget {
  const Favorits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorits"),
        backgroundColor: MyColorsPalette.lightBlue,
      ),
      backgroundColor: MyColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: const MyDrawer("Favorits",username:"Superjuane", email:"juaneolivan@gmail.com"),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
          child: EventContainer(),
        ),
      ),
    );
  }
}