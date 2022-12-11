import 'package:CatCultura/views/screens/favorits.dart';
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
      case '/rutaCultural':
        return MaterialPageRoute(builder:(_)=>RutaCultural());
      case '/crear-esdeveniment':
        return MaterialPageRoute(builder:(_)=>crearEsdeveniments());
      case '/another-user-profile':
        final argsAnotherProfile = settings.arguments as AnotherProfileArgs;
        return MaterialPageRoute(builder:(_)=>AnotherProfile(selectedUser: argsAnotherProfile.selectedUser, selectedId: argsAnotherProfile.selectedId));
      case '/createUser':
        return MaterialPageRoute(builder:(_)=>CreateUser());
      case '/editProfile':
        return MaterialPageRoute(builder:(_)=>EditProfile());
      case '/favorits':
        return MaterialPageRoute(builder: (_)=>Favorits());
      case '/profileSettings':
        return MaterialPageRoute(builder:(_)=>ProfileSettings());
      case '/agenda':
        return MaterialPageRoute(builder:(_)=>Agenda());
      case '/eventUnic':
        final argsEventUnic = settings.arguments as EventUnicArgs;
        return MaterialPageRoute(builder:(_)=>EventUnic(eventId: argsEventUnic.eventId));
      case '/reviewUnica':
        final argsReviewUnica = settings.arguments as ReviewUnicaArgs;
        return MaterialPageRoute(builder:(_)=>ReviewUnica(review: argsReviewUnica.review));
      case '/modificar-Esdeveniment':
        return MaterialPageRoute(builder:(_)=>modificarEsdeveniment());
      case '/opcions-Esdeveniment':
        final argsEventUnic = settings.arguments as EventUnicArgs;
        return MaterialPageRoute(builder:(_)=>opcionsEsdeveniment(eventId: argsEventUnic.eventId));
      case '/userTags':
        return MaterialPageRoute(builder:(_)=>UserTags());
      case '/friendRequests':
        return MaterialPageRoute(builder:(_)=>FriendRequests());

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