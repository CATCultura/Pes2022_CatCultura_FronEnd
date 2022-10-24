import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:CatCultura/constants/theme.dart';

class MyDrawer extends Drawer {
  const MyDrawer(this.actualPage,
      {this.username = "", this.email = "", super.key});
  final String actualPage;
  final String username;
  final String email;

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
                if (actualPage == "Profile") {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                          radius: 36.0,
                          backgroundColor: MyColorsPalette.white,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/99893934?s=400&u=cc0636970f96e71b96dfb4696945dc0a95ebb787&v=4")),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(username,
                          style: const TextStyle(
                              fontSize: 25, color: MyColorsPalette.white)),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        email,
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
            title: const Text('Home', style: TextStyle(fontSize: 18)),
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
            title: const Text('Map', style: TextStyle(fontSize: 18)),
            onTap: () {
              if (actualPage == "Map") {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/map');
              }
            },
          ),
          ListTile(
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
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.star, size: 28),
            title: const Text('Favorits', style: TextStyle(fontSize:18)),
            onTap: (){
              if(actualPage == "Favorits"){
                Navigator.pop(context);
          }
              else{
                Navigator.pushReplacementNamed(context, '/favorits');
          }
          }
          ),
          ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.calendar_month, size: 28),
              title: const Text('Agenda', style: TextStyle(fontSize:18)),
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
                Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
