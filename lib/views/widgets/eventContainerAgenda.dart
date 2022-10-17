import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';

//import 'package:tryproject2/constants/theme.dart';
//import 'package:tryproject2/viewModels/EventContainerViewModel.dart';

class EventContainerAgenda extends StatelessWidget {
  const EventContainerAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulEventContainerAgenda(),
    );
  }
}

class StatefulEventContainerAgenda extends StatefulWidget {
  const StatefulEventContainerAgenda({super.key});

  @override
  State<StatefulEventContainerAgenda> createState() => _StatefulEventContainerAgendaState();
}

class _StatefulEventContainerAgendaState extends State<StatefulEventContainerAgenda> {
  //var viewModel = EventContainerViewModel();
  bool _esFavorit = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //PARTE 1
        /*Container(
            height: 16,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.lightRed)),
              child: const Text('Filtrar'),
              onPressed: () {
                //no fa res de moment
                },
            )
        ),*/
        Row(
          children:[
            const Padding(padding: EdgeInsets.only(left: 18)),
            Text(
                "dimecres 30 de febrer \n",
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
                        Text("aniversari juane "),
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
                        Text("casa juane"),
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
                            Navigator.popAndPushNamed(context, '/events'); // encara no es pot veure un event en concret
                          },
                        )
                    ),
                  ],
                ),
              ),
              //IMATGE
             /* Expanded(
                child: SizedBox(
                  //height: 1,
                    child: Image.network(viewModel.img)),
              ),*/
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