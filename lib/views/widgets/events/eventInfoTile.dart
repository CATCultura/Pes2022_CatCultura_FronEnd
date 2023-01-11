import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';
import '../../../utils/auxArgsObjects/argsRouting.dart';

class EventInfoTile extends StatelessWidget {
  final EventResult event;
  final int index;
  final String mode;

  EventInfoTile({super.key, required this.event, required this.index, this.mode = "normal"});

  var color;
  var leading;

  void modeSetup(BuildContext context){
    if(mode == "noSimilar"){
      color = Colors.white;
      leading = SizedBox(width: 0,height: 0,);
    }
    else{
      color = Colors.white;
      leading = CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Text(
          (index+1).toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("*************** MODE: $mode");
    modeSetup(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
          onTap: () {
            debugPrint("clicked event: ${event.denominacio}");
           Navigator.pushNamed(context, "/eventUnic",
                arguments: EventUnicArgs(event.id!)).then((_){
            });
          },
          leading: leading,
          tileColor: color,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(event.denominacio!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.redAccent
                )),
            const SizedBox(height: 15.0,),
            Row(
              children: [
                const Icon(Icons.calendar_month,
                  color: Colors.black26,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text("${event.dataInici!}  /  ${event.dataFi!}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.place,
                  color: Colors.black26,
                ),
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        event.ubicacio!,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    )
                ),
              ],
            ),
          ])),

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
