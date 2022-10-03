import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';

//import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/viewModels/EventContainerViewModel.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulEventContainer(),
    );
  }
}

class StatefulEventContainer extends StatefulWidget {
  const StatefulEventContainer({super.key});

  @override
  State<StatefulEventContainer> createState() => _StatefulEventContainerState();
}

class _StatefulEventContainerState extends State<StatefulEventContainer> {
  var viewModel = EventContainerViewModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //PARTE 1
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          child: Row(
            children: [
              //DATA-ESPAI-COMARCA
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
                        Text("${viewModel.dataInici} \n${viewModel.dataFi}"),
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
                        Text(viewModel.espai),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Row(
                      children: [
                        const Icon(
                          Icons.earbuds_rounded,
                          color: MyColorsPalette.red,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 16)),
                        Text(viewModel.ComarcaMunicipi),
                      ],
                    ),
                  ],
                ),
              ),
              //IMATGE
              Expanded(
                child: SizedBox(
                    //height: 1,
                    child: Image.network(viewModel.img)),
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
                  // Container(
                  //   color: MyColorsPalette.lightRed,
                  //   child: Center(
                  //     child: Text(
                  //       viewModel.NomEvent,
                  //       style: const TextStyle(color: MyColorsPalette.white,
                  //           fontSize: 30, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  // const Padding(padding: EdgeInsets.only(top: 20)),
                  Expanded(child: const EventContainerPersonalizedTabs()),
                ],
              )),
        ),
      ],
    );
  }
}

class EventContainerPersonalizedTabs extends StatefulWidget {
  const EventContainerPersonalizedTabs({super.key});

  @override
  State<EventContainerPersonalizedTabs> createState() => _EventContainerPersonalizedTabsState();
}

class _EventContainerPersonalizedTabsState extends State<EventContainerPersonalizedTabs> {
  var viewModel = EventContainerViewModel();

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
          text: 'Espai')
    ];

    return DefaultTabController(
      length: Tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColorsPalette.red,
          title: Center(
            child: Text(
                viewModel.NomEvent,
                style: const TextStyle(color: MyColorsPalette.white,
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
          ),
          bottom: TabBar(
            tabs: Tabs,
          ),
        ),
        body: TabBarView(
          children:[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(viewModel.description, textAlign: TextAlign.justify,style: TextStyle(fontSize: 20, ),),
            ),
            Text("${viewModel.dataInici}\n${viewModel.dataFi}"),
            Text("${viewModel.espai}\n${viewModel.ComarcaMunicipi}")
          ],
        ),
      ),
    );
  }
}
