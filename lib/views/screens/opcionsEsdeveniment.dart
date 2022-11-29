import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../widgets/events/eventInfoShort.dart';


class opcionsEsdeveniment extends StatelessWidget {
  opcionsEsdeveniment({super.key, required this.eventId});
  String eventId;

  /*+@override
  State<opcionsEsdeveniment> createState() => _opcionsState(); **/

//}

//class _opcionsState extends State<opcionsEsdeveniment> {
  final EventUnicViewModel viewModel = EventUnicViewModel();
  //late String eventId;

  @override
  Widget build(BuildContext context) {
    print("estas a l'apartat opcions");
    print(eventId);
    return ChangeNotifierProvider<EventUnicViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
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
                                                viewModel.deleteEventById(eventId);
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
                    : viewModel.eventSelected.status == Status.LOADING? const SizedBox(
                        child: Center(child: CircularProgressIndicator()),
          )
                    : viewModel.eventSelected.status == Status.ERROR? Text(viewModel.eventSelected.toString())
                    : viewModel.eventSelected.status == Status.COMPLETED? EventInfoShort(event: viewModel.eventSelected.data!): Text ("Tot correcte")
              ),
          );
    }));
  }
}
