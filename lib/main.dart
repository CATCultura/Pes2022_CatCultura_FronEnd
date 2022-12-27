import 'package:CatCultura/providers/xat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:CatCultura/utils/routes/RouteGenerator.dart';
import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
//import 'package:architecture_demos/res/app_theme.dart';
//import 'package:architecture_demos/utils/routes/routes_name.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/notifications/notificationService.dart';
//import 'utils/routes/routes.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  debugPaintSizeEnabled=false;
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
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
        ChangeNotifierProvider(create: (_) => XatProvider()),
      ],
      child: MaterialApp(
          title: 'catcultura',
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ca', ''),
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Spanish, no country code
          ],
          theme: ThemeData(fontFamily: 'OpenSans'),
          initialRoute: "/login",
          onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}