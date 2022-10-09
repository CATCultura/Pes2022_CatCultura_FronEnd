import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/eventContainer.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

class hhr extends StatelessWidget {
  const hhr({super.key});


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Events extends StatelessWidget {
  const Events({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        backgroundColor: MyColorsPalette.red,
      ),
      backgroundColor: MyColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: const MyDrawer("Events",username:"Superjuane", email:"juaneolivan@gmail.com"),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
          child: EventContainer(),
        ),
      ),
    );
  }
}

