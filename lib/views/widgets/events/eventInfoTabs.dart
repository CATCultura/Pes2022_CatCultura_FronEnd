
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../models/EventResult.dart';

class EventInfoTabs extends StatefulWidget {
  final EventResult? event;
  const EventInfoTabs({super.key, this.event});

  @override
  State<EventInfoTabs> createState() =>
      _EventInfoTabsState();
}

class _EventInfoTabsState extends State<EventInfoTabs> {
  late EventResult? event =  widget.event;
  bool Favorit = false;
  bool assistire = false;

  @override
  Widget build(BuildContext context) {
    final Tabs = <Widget>[
      const Tab(
        icon: Icon(Icons.info_outline, size: 20.0, color: MyColorsPalette.white),
        text: 'Info',
      ),
      const Tab(
          icon: Icon(Icons.hourglass_bottom,
              size: 20.0, color: MyColorsPalette.white),
          text: 'Data'),
      const Tab(
          icon:
          Icon(Icons.park_outlined, size: 20.0, color: MyColorsPalette.white),
          text: 'Espai'),
      IconButton(
        padding: const EdgeInsets.only(bottom: 5.0),
        iconSize: 40,
        icon: Icon((assistire == false) ? Icons.flag_outlined : Icons.flag, color: MyColorsPalette.white),
        onPressed: (){
          setState(() {
            assistire = !assistire;
          });
        },
      ),
      IconButton(
        padding: const EdgeInsets.only(bottom: 5.0),
        iconSize: 40,
        icon: Icon((Favorit == false) ? Icons.star_border_outlined : Icons.star, color: MyColorsPalette.white),
        onPressed: (){
          setState(() {
            Favorit = !Favorit;
          });
        },
      ),

    ];
    return DefaultTabController(
      length: Tabs.length-2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: MyColorsPalette.red,
            title: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  event!.denominacio!,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(color: MyColorsPalette.white,
                    fontWeight: FontWeight.bold, ),
                ),
              ),
            ),
            bottom: TabBar(
              tabs: Tabs,
            ),
          ),
        ),
        body: TabBarView(
          children:[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(child:Text(event!.descripcio!, textAlign: TextAlign.justify,style: const TextStyle(fontSize: 20, ),),),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("${event!.dataInici}\n${event!.dataFi}"),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("${event!.localitat!}\n${event!.comarcaIMunicipi!}"),
            )
          ],
        ),
      ),
    );
  }

}
