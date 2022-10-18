import 'package:flutter/material.dart';
import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/login':
        return MaterialPageRoute(builder:(_)=>Login());
      case '/home':
        return MaterialPageRoute(builder:(_)=>Home());
      case '/profile':
        return MaterialPageRoute(builder:(_)=>Profile());
      case '/events':
        return MaterialPageRoute(builder:(_)=>Events());
      case '/map':
        return MaterialPageRoute(builder:(_)=>Map());
      case '/crear-esdeveniment':
        return MaterialPageRoute(builder:(_)=>crearEsdeveniments());
      case '/another-user-profile':
        return MaterialPageRoute(builder:(_)=>AnotherProfile());
      case '/createUser':
        return MaterialPageRoute(builder:(_)=>CreateUser());
      case '/editProfile':
        return MaterialPageRoute(builder:(_)=>EditProfile());
      case '/profileSettings':
        return MaterialPageRoute(builder:(_)=>ProfileSettings());
      // case '/favorits':
      //   return MaterialPageRoute(builder:(_)=>Favorits());
      case '/agenda':
        return MaterialPageRoute(builder:(_)=>Agenda());
      case '/eventUnic':
        final argsEventUnic = settings.arguments as EventUnicArgs;
        return MaterialPageRoute(builder:(_)=>EventUnic(viewModel: argsEventUnic.viewModel, eventId: argsEventUnic.eventId));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title:Text("ERROR")),
        body: Center(child:Text("ERROR")),
        drawer: MyDrawer(""),
      );
    });
  }
}