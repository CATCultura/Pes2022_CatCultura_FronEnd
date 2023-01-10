import 'package:flutter/material.dart';
import 'package:CatCultura/constants/theme.dart';

import '../../../models/EventResult.dart';
import '../../../utils/auxArgsObjects/argsRouting.dart';

class CardSmall extends StatelessWidget {
  final EventResult event;

  const CardSmall(this.event, {super.key});

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/eventUnic",
              arguments: EventUnicArgs(event.id!)).then((_){
            /*setState((){

                });*/
          });
        },
        child: Card(
            elevation: 0.4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0)),
                            image: DecorationImage(
                              image: NetworkImage("https://agenda.cultura.gencat.cat/${event.imatges![0]}"),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: SingleChildScrollView (
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.denominacio!,
                                style: TextStyle(
                                    color: MyColors.header, fontSize: 13)),
                          ],
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
