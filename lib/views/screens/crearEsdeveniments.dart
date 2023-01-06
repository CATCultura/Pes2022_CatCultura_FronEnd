// import 'dart:ffi';

import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/views/widgets/attributes.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../viewModels/EventsViewModel.dart';


class crearEsdeveniments extends StatefulWidget {
  crearEsdeveniments({super.key});

  @override
  State<crearEsdeveniments> createState() => _crearEsdevenimentsState();
}

class _crearEsdevenimentsState extends State<crearEsdeveniments> {
  final EventsViewModel viewModel = EventsViewModel();

  String fecha = '';
  TextEditingController CodiController = TextEditingController();
  TextEditingController InitialDateController = TextEditingController();
  TextEditingController FinalDateController = TextEditingController();
  TextEditingController DenominacioController = TextEditingController();
  TextEditingController UbicacioController = TextEditingController();
  TextEditingController AdrecaController = TextEditingController();
  TextEditingController EspaiController = TextEditingController();

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
                  title: const Text("Crear Esdeveniment"),
                  backgroundColor: MyColorsPalette.orange,
                ),
                drawer: MyDrawer("Crear Esdeveniment",  Session(), username: "Superjuane",
                  email: "juaneolivan@gmail.com"),
                body: SingleChildScrollView(
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          //attributes("Codi"),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: CodiController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Codi',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 3
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //createInitialDate(context),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              enableInteractiveSelection: false,
                              controller: InitialDateController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Data Inici",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 3
                                  ),
                                ),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                selectInitialDate(context);
                              },
                            ),
                          ),

                          //createFinalDate(context),
                          Container(
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
                                FocusScope.of(context).requestFocus(new FocusNode());
                                selectFinalDate(context);
                              },
                            ),
                          ),

                          //attributes("Nom Esdeveniment"),
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

                          //attributes("Ubicació"),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: UbicacioController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ubicació',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 3
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: AdrecaController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Adreça',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 3
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: EspaiController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Espai',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 3
                                  ),
                                ),
                              ),
                            ),
                          ),


                          Container(
                            height: 70,
                            width: 150,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      MyColorsPalette.orange)),
                              child: const Text('Crear'),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/home');
                                EventResult? e = EventResult();
                                e.codi = CodiController.text;
                                e.denominacio = DenominacioController.text;
                                e.dataInici = InitialDateController.text;
                                e.dataFi = FinalDateController.text;
                                e.ubicacio = UbicacioController.text;
                                e.adreca = AdrecaController.text;
                                e.espai = EspaiController.text;
                                viewModel.crearEvent(e);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  : viewModel.events.status == Status.LOADING? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
              )
                  : viewModel.events.status == Status.ERROR? Text(viewModel.events.toString())
                  : viewModel.events.status == Status.COMPLETED? EventCreat(): Text ("Esdeveniment creat")
            ),
          );
        }));
  }

  /* Widget createInitialDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextField(
          enableInteractiveSelection: false,
          controller: InitialDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Data Inici",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange,
                  width: 3
              ),
            ),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            selectInitialDate(context);
          },
        ),
      ),
    );
  }*/

  /* Widget createFinalDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
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
            FocusScope.of(context).requestFocus(new FocusNode());
            selectFinalDate(context);
          },
        ),
      ),
    );
  } */

  selectInitialDate(BuildContext context) async{
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
        InitialDateController.text = fecha;
      });
    }
  }

  selectFinalDate(BuildContext context) async{
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
  }
}

class EventCreat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Navigator.popAndPushNamed(context, '/home');
    return Container();
  }
}





