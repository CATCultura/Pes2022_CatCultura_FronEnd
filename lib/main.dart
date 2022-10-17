import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tryproject2/views/screens/agenda.dart';
//import 'package:tryproject2/views/screens/favorits.dart';
import 'package:tryproject2/views/screens/createUser.dart';

import 'package:tryproject2/views/screens/crearEsdeveniments.dart';

import 'package:tryproject2/views/screens/home.dart';
import 'package:tryproject2/views/screens/login.dart';
import 'package:tryproject2/views/screens/profile.dart';
import 'package:tryproject2/views/screens/events.dart';
import 'package:tryproject2/views/screens/map.dart';
import 'package:tryproject2/views/screens/editProfile.dart';
import 'package:tryproject2/views/screens/profileSettings.dart';

import 'package:tryproject2/views/screens/search-user.dart';
import 'dart:io';
//import 'package:architecture_demos/res/app_theme.dart';
//import 'package:architecture_demos/utils/routes/routes_name.dart';
import 'package:tryproject2/viewModels/EventsViewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
//import 'utils/routes/routes.dart';

void main() {
  debugPaintSizeEnabled=false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventsViewModel()),
      ],
      child: MaterialApp(
          title: 'catcultura',
          theme: ThemeData(fontFamily: 'OpenSans'),
          initialRoute: "/login",
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "/login": (BuildContext context) => const Login(),
            "/home": (BuildContext context) => Home(),
            "/profile":(BuildContext context) => const Profile(),
            "/events":(BuildContext context) => Events(),
            "/map":(BuildContext context) => Map(),
            "/crear esdeveniment":(BuildContext context) => crearEsdeveniments(),
          "/search-user":(BuildContext context) => const SearchUser(),
    "/createUser":(BuildContext context) => CreateUser(),
    "/editProfile":(BuildContext context) => EditProfile(),
    "/profileSettings":(BuildContext context) => ProfileSettings(),
            //"/favorits":(BuildContext context) => Favorits(),
            "/agenda":(BuildContext context) => Agenda(),
          }),
    );

  }
}

