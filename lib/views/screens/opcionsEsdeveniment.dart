import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../viewModels/EventsViewModel.dart';


class opcionsEsdeveniment extends StatefulWidget {
  const opcionsEsdeveniment({super.key});

  @override
  State<opcionsEsdeveniment> createState() => _opcionsState();
}

class _opcionsState extends State<opcionsEsdeveniment> {
  final EventsViewModel viewModel = EventsViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.fetchEvents();
    return ChangeNotifierProvider<EventsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventsViewModel>(builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child:
                viewModel.waiting? Scaffold(
                  appBar: AppBar(
                    title: const Text('Opcions'),
                    backgroundColor: Colors.blue,
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                                MyColorsPalette.blue)),
                            child: const Text('Modificar Esdeveniment'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/modificar-Esdeveniment');
                            },
                          ),
                        ),

                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                                MyColorsPalette.blue)),
                            child: const Text('Eliminar Esdeveniment'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                        title: Text("Eliminar Esdeveniment"),
                                        content: Text(
                                            "Estas segur que vols eliminar aquest esdeveniment?"),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("Si"),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Navigator.popAndPushNamed(
                                                    context, '/home');
                                              }
                                          ),

                                          TextButton(
                                              child: Text("No"),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }
                                          ),
                                        ]
                                    ),
                              );
                            },
                          ),
                        ),

                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                                MyColorsPalette.blue)),
                            child: const Text('Cancel·lar Esdeveniment'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                        title: Text("Cancel·lar Esdeveniment"),
                                        content: Text(
                                            "Estas segur que vols cancel·lar aquest esdeveniment?"),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("Si"),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Navigator.popAndPushNamed(
                                                    context, '/home');
                                              }
                                          ),

                                          TextButton(
                                              child: Text("No"),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }
                                          ),
                                        ]
                                    ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : viewModel.event.status == Status.LOADING? const SizedBox(
                        child: Center(child: CircularProgressIndicator()),
          )
                    : viewModel.event.status == Status.ERROR? Text(viewModel.event.toString())
                    : viewModel.event.status == Status.COMPLETED? OpcioRealitzada(): Text ("Tot correcte")
              ),
          );
    }));
  }
}

class OpcioRealitzada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Navigator.popAndPushNamed(context, '/home');
    return Container();
  }
}
