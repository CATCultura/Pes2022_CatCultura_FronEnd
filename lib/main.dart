import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:CatCultura/utils/routes/RouteGenerator.dart';
import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:flutter/services.dart';

import 'dart:io';
//import 'package:architecture_demos/res/app_theme.dart';
//import 'package:architecture_demos/utils/routes/routes_name.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventsViewModel()),
      ],
      child: MaterialApp(
          title: 'catcultura',
          theme: ThemeData(fontFamily: 'OpenSans'),
          initialRoute: "/login",
          onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

