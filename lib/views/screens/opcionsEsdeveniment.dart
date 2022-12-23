import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/models/EventResult.dart';

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
  String fecha = '';
  TextEditingController CodiController = TextEditingController();
  TextEditingController InitialDateController = TextEditingController();
  TextEditingController FinalDateController = TextEditingController();
  TextEditingController DenominacioController = TextEditingController();
  TextEditingController UbicacioController = TextEditingController();
  TextEditingController AdrecaController = TextEditingController();
  TextEditingController EspaiController = TextEditingController();


  //CodiController = viewModel.eventSelected.data!.codi! as TextEditingController;
  //InitialDateController = viewModel.eventSelected.data!.dataInici! as TextEditingController;
  //FinalDateController = viewModel.eventSelected.data!.dataFi! as TextEditingController;
  //DenominacioController = viewModel.eventSelected.data!.denominacio! as TextEditingController;
  //UbicacioController = viewModel.eventSelected.data!.ubicacio! as TextEditingController;
  //AdrecaController = viewModel.eventSelected.data!.adreca! as TextEditingController;
  //EspaiController = viewModel.eventSelected.data!.espai! as TextEditingController;

  @override
  Widget build(BuildContext context) {
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
                    title: const Text('Que vols fer?'),
                    backgroundColor: Colors.blue,
                  ),
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.delete),
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
                                                  viewModel.deleteEventById("3233");
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

                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.cancel),
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
                                                  //viewModel.putEventById("3056");
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
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            controller: DenominacioController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nom Esdeveniment',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 3
                                ),
                              ),
                            ),
                          ),
                        ),

                        /** Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            enableInteractiveSelection: false,
                            controller: FinalDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Data Fi",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 3
                                ),
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context).requestFocus(
                                  new FocusNode());
                              selectFinalDate(context);
                            },
                          ),
                        ), **/

                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  MyColorsPalette.orange)),
                            child: const Text('Modificar'),
                            onPressed: () {
                              EventResult? e = EventResult();
                              e.id = "3233";
                              e.denominacio = DenominacioController.text;
                              e.codi = "123456789";//CodiController.text;
                              e.dataFi = "2022-12-31"; //FinalDateController.text;
                              e.dataInici = "2022-12-30"; //InitialDateController.text;
                              e.adreca = "BCN"; //AdrecaController.text;
                              e.espai = "Ningun"; //EspaiController.text;
                              e.ubicacio = "BCN"; //UbicacioController.text;
                              viewModel.putEventById(e);
                              Navigator.pushNamed(context, '/home');
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

  /** selectFinalDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2999),
    );
    if (picked != null) {
      var date = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        fecha = date;
        FinalDateController.text = fecha;
      });
    }
  } **/

}
