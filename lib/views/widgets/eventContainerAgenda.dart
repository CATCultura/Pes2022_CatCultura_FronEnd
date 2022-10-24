import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';

import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
//import 'package:tryproject2/constants/theme.dart';
import '../../../utils/auxArgsObjects/argsRouting.dart';

class EventContainerAgenda extends StatelessWidget {

  final EventResult event;

  const EventContainerAgenda({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
            children:[
              const Padding(padding: EdgeInsets.only(left: 18)),
              Text(
                "${event.dataInici!}\n${event.dataFi!}",
                style: TextStyle(fontWeight: FontWeight.bold),),

            ]
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: MyColorsPalette.red,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 16)),
                        Text(event.denominacio!),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: MyColorsPalette.red,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 16)),
                        Text(event.localitat!),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Container(
                        height: 16,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.lightRed)),
                          child: const Text('Detalls event'),
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                "/eventUnic",
                                //arguments: EventUnicArgs(event.id!)
                            );
                          },
                        )
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        //PARTE 2
        Expanded(
          child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                ),
              ),
              //padding: const EdgeInsets.only(top:25.0),
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ],
              )),
        ),
      ],
    );
  }
}