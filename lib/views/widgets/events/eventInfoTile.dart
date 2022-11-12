import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';

import '../../../utils/auxArgsObjects/argsRouting.dart';

class EventInfoTile extends StatelessWidget {

  final EventResult event;
  final int index;

  const EventInfoTile({super.key, required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () {
            debugPrint("clicked event: ${event.denominacio}");
            Navigator.pushNamed(
                context,
                "/eventUnic",
                arguments: EventUnicArgs(event.id!)
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Column(children: [
            Text(index.toString()+" - " + event.denominacio!,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                    "${event.dataInici!}\n${event.dataFi!}"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: [
                const Icon(Icons.place),
                Text(event.localitat!),
              ],
            ),
          ])),
    );
  }
}


