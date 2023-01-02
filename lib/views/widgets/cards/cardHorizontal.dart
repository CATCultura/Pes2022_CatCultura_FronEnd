import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:CatCultura/constants/theme.dart';

import '../../../models/EventResult.dart';
import '../../../utils/auxArgsObjects/argsRouting.dart';

class CardHorizontal extends StatelessWidget {
  final EventResult event;

  const CardHorizontal(this.event, {super.key});


  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/eventUnic",
                arguments: EventUnicArgs(event.id!)).then((_){
              /*setState((){

                    });*/
            });
          },
          child: Card(
            color: Colors.white,
            elevation: 0.6,

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage("https://agenda.cultura.gencat.cat/${event.imatges![0]}"),
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.centerLeft
                          ))),
                ),
                Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.denominacio!,
                              style: const TextStyle(
                                  color: MyColors.header, fontSize: 13),
                                  textAlign: TextAlign.left,
                          ),
                          const Divider(thickness: 4, height: 1, indent: 5,),
                          Flexible(
                            flex:1,
                            child: Text("${event.descripcio!.substring(0,min(event.descripcio!.length,150))}...",
                              style: const TextStyle(
                                  color: MyColors.text, fontSize: 13),
                                  textAlign: TextAlign.justify,

                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
