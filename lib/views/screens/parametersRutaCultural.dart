import 'dart:ui';

import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  SelectionScreenState createState() => SelectionScreenState();
}


class SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              child: Image.asset(
                'resources/img/backgroundPhoto.jpg',
                // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                        child: SizedBox(
                          width: size.width * .9,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.width * .15,
                                  bottom: size.width * .1,
                                ),
                                child: Text(
                                  'OPCIONS',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(.8),
                                  ),
                                ),
                              ),
                              component(
                                Icons.question_mark,
                                'OPTION 1',
                                false,
                                false,
                                size
                              ),
                              component(
                                Icons.question_mark,
                                'OPTION 2',
                                true,
                                false,
                                size
                              ),

                              SizedBox(height: size.width * .3),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context, RutaCulturalArgs(1.0, 2.0, 3.0));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: size.width * .05,
                                  ),
                                  height: size.width / 8,
                                  width: size.width / 1.25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'GENERAR RUTA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    ),
    );
  }
  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail, Size size) {
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}