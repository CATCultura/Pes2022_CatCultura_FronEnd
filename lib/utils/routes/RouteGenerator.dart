import 'package:CatCultura/utils/routes/deepLinkParams.dart';
import 'package:CatCultura/views/screens/favorits.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import '../../views/screens/xat.dart';


import '../../views/screens/organizerEvents.dart';
import '../../views/widgets/errorWidget.dart';
import '../Session.dart';



class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    if($LatestUri != null){
      print("LatestUri: " + $LatestUri.toString());
      if($LatestUri!.path == "/rutaCultural"){
        $LatestUri = null;
        return MaterialPageRoute(builder: (_) => RutaCultural());
      }
    }
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
      case '/crearReview':
        final argsCrearReview = settings.arguments as CrearReviewArgs;
        return MaterialPageRoute(builder:(_)=>CrearReview(eventId: argsCrearReview.eventId));
      //case '/modificar-Esdeveniment':
        return MaterialPageRoute(builder:(_)=>modificarEsdeveniment());
      case '/opcions-Esdeveniment':
        final argsEvent = settings.arguments as EventArgs;
        return MaterialPageRoute(builder:(_)=>opcionsEsdeveniment(event: argsEvent.e));
      case '/userTags':
        final argsCreateUser = settings.arguments as CrearUserArgs;
        return MaterialPageRoute(builder:(_)=>UserTags(name: argsCreateUser.name, user: argsCreateUser.user, email: argsCreateUser.email, password: argsCreateUser.password));
      case '/friendRequests':
        return MaterialPageRoute(builder:(_)=>FriendRequests());
      case '/trophies':
        return MaterialPageRoute(builder:(_)=>Trophies());
      case '/userEditTags':
        return MaterialPageRoute(builder:(_)=>UserEditTags());
      case '/organizer':
        final argsOrganizerId = settings.arguments as OrganizerArgs;
        return MaterialPageRoute(builder:(_)=>OrganizerEvents(argsOrganizerId.orgId, organizerName: argsOrganizerId.orgName,));
      case '/allUsers':
        return MaterialPageRoute(builder:(_)=>AllUsers());
      case '/xat':
         final argsEventUnic = settings.arguments as EventUnicArgs;
        return MaterialPageRoute(builder:(_)=>Xat(argsEventUnic.eventId));
      case '/blocks':
        return MaterialPageRoute(builder:(_)=>Blocks());
      default:
        // return _errorRoute();
        return MaterialPageRoute(builder:(_)=>Home());
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title:Text("ERROR")),
        body: const CustomErrorWidget(),
        drawer: MyDrawer("", Session()),
      );
    });
  }
}

