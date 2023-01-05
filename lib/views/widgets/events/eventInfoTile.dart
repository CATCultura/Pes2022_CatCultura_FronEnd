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
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 20,
        shadowColor: Colors.black.withAlpha(70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
            onTap: () {
              debugPrint("clicked event: ${event.denominacio}");
             Navigator.pushNamed(context, "/eventUnic",
                  arguments: EventUnicArgs(event.id!)).then((_){
                    /*setState((){

                    });*/
              });
            },
            leading: CircleAvatar(
              backgroundColor: Colors.red.shade700,
              child: Text((index+1).toString()),
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF818181), width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            tileColor: Theme.of(context).cardColor,
            title: Column(children: [
              Text(event.denominacio!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              const Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text("${event.dataInici!}\n${event.dataFi!}"),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                children: [
                  const Icon(Icons.place),
                  Flexible(child: Text(event.ubicacio!, style: const TextStyle(overflow: TextOverflow.fade),)),
                ],
              ),
            ])),
      ),
      /*ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(dummyList[index]["id"].toString()),
          ),
          title: Text(dummyList[index]["title"]),
          subtitle: Text(dummyList[index]["subtitle"]),
          trailing: const Icon(Icons.add_a_photo),
        ),*/
    );
  }
}
