import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../data/response/apiResponse.dart';
import '../../models/UserResult.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/Session.dart';

class MyDrawer extends Drawer {
  const MyDrawer(this.actualPage,this.session,
      {this.username = "", this.email = "", super.key});
  final String actualPage;
  final String username;
  final String email;
  final Session session;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: MyColorsPalette.blue,
            ),
            child: InkWell(
              onTap: () {
                if (session.data.id != -1) {
                  if (actualPage == "Profile") {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                }
                else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
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
                      Text(session.data.username == "Anonymous" ? AppLocalizations.of(context)!.anonymousUser : session.data.username,
                          style: const TextStyle(
                              fontSize: 25, color: MyColorsPalette.white)),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        session.data.email ?? AppLocalizations.of(context)!.missingEmail,
                        style: const TextStyle(
                            fontSize: 12, color: MyColorsPalette.white),
                      ),
                    ]),
              ),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.house_outlined, size: 28),
            title: Text(AppLocalizations.of(context)!.homeScreenTitle, style: TextStyle(fontSize: 18)),
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
            title: const Text('Events', style: TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "Events") {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/events');
              }
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.map, size: 28),
            title: const Text('Ruta Cultural', style: TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "rutaCultural") {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/rutaCultural');
              }
            },
          ),
          if (session.data.role == "ADMIN" || session.data.role == "ORGANIZER" )ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.create, size: 28),
            title: const Text('Crear Esdeveniment', style: TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "CrearEsdeveniment") {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/crear-esdeveniment');
              }
            },
          ),
          if (session.data.id != -1) ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.star, size: 28),
            title: Text(AppLocalizations.of(context)!.favouritesTitle, style: TextStyle(fontSize:18)),
            onTap: (){
              if(actualPage == "Favorits"){
                Navigator.pop(context);
          }
              else{
                Navigator.pushReplacementNamed(context, '/favorits');
          }
          }
          ),
          if (session.data.id != -1) ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.calendar_month, size: 28),
              title: Text(AppLocalizations.of(context)!.agendaTitle, style: TextStyle(fontSize:18)),
              onTap: (){
                if(actualPage == "Agenda"){
                  Navigator.pop(context);
                }
                else{
                  Navigator.pushReplacementNamed(context, '/agenda');
                }
              }
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: const Text('Tancar sessió', style: TextStyle(fontSize: 18)),
            onTap: () {
              session.deleteSession();
                Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
