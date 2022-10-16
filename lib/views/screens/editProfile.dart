//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulEditProfile(),
    );
  }
}

class StatefulEditProfile extends StatefulWidget {
  const StatefulEditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulEditProfile> createState() => _StatefulEditProfileState();
}

class _StatefulEditProfileState extends State<StatefulEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPasswordActual = false;
  bool showPasswordNew = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Edita el teu perfil",
            style: TextStyle (
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            )
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/profile');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/profileSettings');
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left:16, top: 25, right:16),
          /*
          si està el teclat obert, al clicar a qualsevol punt
          de la pantalla, desapareix
          */
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Center (
                  child:Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow (
                              spreadRadius: 2, blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset:const Offset(0, 10)
                            )
                          ],
                          shape: BoxShape.circle,
                          image:const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage( "https://avatars.githubusercontent.com/u/99893934?s=400&u=cc0636970f96e71b96dfb4696945dc0a95ebb787&v=4")
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration (
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            color: Colors.blueAccent,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.only(left:16, top: 30, right:16),
                  child: TextField(
                    decoration: InputDecoration (
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Nom i cognoms",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Juan Emilio Olivan",
                      hintStyle: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left:16, top: 30, right:16),
                  child: TextField(
                    decoration: InputDecoration (
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Nom d'usuari",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "superjuane",
                        hintStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left:16, top: 30, right:16),
                  child: TextField(
                    decoration: InputDecoration (
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Correu electrònic",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "juaneolivan@gmail.com",
                        hintStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16, top: 30, right:16),
                  child: TextField(
                    obscureText: !showPasswordActual,
                    decoration: InputDecoration (
                      suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPasswordActual = ! showPasswordActual;
                              });
                            },
                            icon: const Icon (
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 3),
                        labelText: "Contrasenya actual",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "******",
                        hintStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16, top: 30, right:16),
                  child: TextField(
                    obscureText: !showPasswordNew,
                    decoration: InputDecoration (
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPasswordNew = ! showPasswordNew;
                            });
                          },
                          icon: const Icon (
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 3),
                        labelText: "Nova contrasenya",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "******",
                        hintStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16, top: 35, right:16),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/profile');
                            },
                            child: const Text("CANCEL·LAR",
                              style: TextStyle (
                                fontSize: 12,
                                letterSpacing: 2.2,
                                color:Colors.black
                              ),
                            ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal:15),
                        child: ElevatedButton(
                          style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
                          child: const Text('ACCEPTAR',
                              style: TextStyle (
                              fontSize: 12,
                              letterSpacing: 2.2,
                              color:Colors.white
                              ),
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/editProfile');
                          },
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
