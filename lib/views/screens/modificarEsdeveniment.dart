import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../models/EventResult.dart';
import '../../viewModels/EventUnicViewModel.dart';
import '../widgets/attributes.dart';
import '../widgets/events/eventInfoShort.dart';

class modificarEsdeveniment extends StatefulWidget {
  final EventResult? event;
  modificarEsdeveniment({super.key, this.event});

  @override
  State<modificarEsdeveniment> createState() => _modificarState();
}

class _modificarState extends State<modificarEsdeveniment> {
  final EventUnicViewModel viewModel = EventUnicViewModel();

  String fecha = '';
  TextEditingController DenominacioController = TextEditingController();
  TextEditingController FinalDateController = TextEditingController();
  //late String eventId;
  late EventResult? event =  widget.event;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventUnicViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child:
                viewModel.waiting ? Scaffold(
                  appBar: AppBar(
                    title: const Text('Modificar Esdeveniment'),
                    backgroundColor: Colors.orange,
                  ),
                  body: Center(
                    child: Column(
                      children: [
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
                              FocusScope.of(context).requestFocus(
                                  new FocusNode());
                              selectFinalDate(context);
                            },
                          ),
                        ),

                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    MyColorsPalette.blue)),
                            child: const Text('Modificar'),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/home');
                              print(event!.id);
                              viewModel.putEventById("11041", DenominacioController.text);
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
                    : viewModel.event.status == Status.COMPLETED? EventModificat(): Text ("Modificat")
            ),
          );
        }));
        }

    /** Widget createFinalDate(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextField(
            enableInteractiveSelection: false,
            controller: FinalDateController,
            decoration: InputDecoration(
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
    } **/

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

class EventModificat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Navigator.popAndPushNamed(context, '/home');
    return Container();
  }
}