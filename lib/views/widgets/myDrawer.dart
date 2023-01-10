import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/Session.dart';

class MyDrawer extends Drawer {
  const MyDrawer(this.actualPage, this.session,
      {/*this.username = "", this.email = "",*/ super.key});
  final String actualPage;
  //final String username;
  //final String email;
  final Session session;
/*username: session.data.username == "Anonymous" ? AppLocalizations.of(context)!.anonymousUser : session.data.username,
                email: session.data.email == "missing email" || session.data.email == null ? AppLocalizations.of(context)!.missingEmail : session.data.email!
*/
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          // decoration: const BoxDecoration(
          //   color: MyColorsPalette.blue,
          // ),
          // child:
          GestureDetector(
            onTap: () {
              if (session.data.id != -1) {
                if (actualPage == "Profile") {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              } else {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColorsPalette.blue,
              ),
              padding: const EdgeInsets.fromLTRB(5, 25, 5, 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const CircleAvatar(
                        radius: 36.0,
                        backgroundColor: MyColorsPalette.white,
                        backgroundImage: AssetImage('resources/img/logo.png')),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                        session.data.username == "Anonymous"
                            ? AppLocalizations.of(context)!.anonymousUser
                            : session.data.username,
                        style: const TextStyle(
                            fontSize: 25, color: MyColorsPalette.white)),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      session.data.email ??
                          AppLocalizations.of(context)!.missingEmail,
                      style: const TextStyle(
                          fontSize: 12, color: MyColorsPalette.white),
                    ),
                  ]),
            ),
          ),
          // ),

          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.house_outlined, size: 28),
            title: Text(AppLocalizations.of(context)!.homeScreenTitle,
                style: const TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "Home") {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.calendar_today_sharp, size: 28),
            title: Text(AppLocalizations.of(context)!.eventScreenTitle,
                style: const TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "Events") {
                Navigator.pop(context);
              } else {
                Navigator.popAndPushNamed(context, '/events');
              }
            },
          ),
          if (session.data.id != -1)
            ListTile(
                horizontalTitleGap: 0,
                leading: const Icon(Icons.star, size: 28),
                title: Text(AppLocalizations.of(context)!.favouritesTitle,
                    style: const TextStyle(fontSize: 18)),
                onTap: () {
                  if (actualPage == "Favorits") {
                    Navigator.pop(context);
                  } else {
                    Navigator.popAndPushNamed(context, '/favorits');
                  }
                }),
          if (session.data.id != -1)
            ListTile(
                horizontalTitleGap: 0,
                leading: const Icon(Icons.calendar_month, size: 28),
                title: Text(AppLocalizations.of(context)!.agendaTitle,
                    style: const TextStyle(fontSize: 18)),
                onTap: () {
                  if (actualPage == "Agenda") {
                    Navigator.pop(context);
                  } else {
                    Navigator.popAndPushNamed(context, '/agenda');
                  }
                }),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.map, size: 28),
            title: Text(AppLocalizations.of(context)!.culturalRouteTitle,
                style: const TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "rutaCultural") {
                Navigator.pop(context);
              } else {
                Navigator.popAndPushNamed(context, '/rutaCultural');
              }
            },
          ),
          if (session.data.role == "ADMIN" || session.data.role == "ORGANIZER")
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.create, size: 28),
              title: Text(AppLocalizations.of(context)!.createEventDrawer,
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                if (actualPage == "CrearEsdeveniment") {
                  Navigator.pop(context);
                } else {
                  Navigator.popAndPushNamed(
                      context, '/crear-esdeveniment');
                }
              },
            ),
          if (session.data.role == "ADMIN")
            ListTile(
              tileColor: Color(0xFFE0E0E0),
              horizontalTitleGap: 0,
              leading: const Icon(Icons.gavel, size: 28),
              title: const Text('Reports',
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                if (actualPage == "Blocks") {
                  Navigator.pop(context);
                } else {
                  Navigator.popAndPushNamed(
                      context, '/blocks');
                }
              },
            ),

          // ListTile(
          //     horizontalTitleGap: 0,
          //     leading: const Icon(Icons.chat, size: 28),
          //     title: const Text('Xat', style: TextStyle(fontSize:18)),
          //     onTap: (){
          //       if(actualPage == "Xat"){
          //         Navigator.pop(context);
          //       }
          //       else{
          //         Navigator.pushReplacementNamed(context, '/xat', arguments: EventUnicArgs("11"));
          //       }
          //     }
          // ),

          if (session.data.id != -1) Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                horizontalTitleGap: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(AppLocalizations.of(context)!.logoutButton,
                      style: TextStyle(fontSize: 18)),
                ),
                onTap: () {
                  session.deleteSession();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
