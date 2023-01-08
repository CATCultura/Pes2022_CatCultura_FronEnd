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
import 'package:CatCultura/utils/routes/deepLinkParams.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'utils/routes/routes.dart';

void setPermissions() async{
  final locStatus = await Permission.location.request();
  final notStatus = await Permission.notification.request();
}

bool _initialUriIsHandled = false;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  debugPaintSizeEnabled=false;
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
  setPermissions();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Uri? _initialUri;
  Uri? _latestUri = $LatestUri;
  Object? _err;
  StreamSubscription? _sub;

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri not initial: $uri');
        setState(() {
          _latestUri = uri;
          $LatestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      _showSnackBar('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll.entries.toList();
    if(queryParams != null){
      debugPrint("queryParams"+queryParams.toString());
      $Params = queryParams[0].value.first;
    }
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
  void _showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}