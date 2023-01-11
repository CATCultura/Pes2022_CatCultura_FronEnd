import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/shared.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/events/eventInfoShort.dart';


class opcionsEsdeveniment extends StatelessWidget {
  opcionsEsdeveniment({super.key, required this.event});
  EventResult event;

  final EventUnicViewModel viewModel = EventUnicViewModel();
  TextEditingController CodiController = TextEditingController();//
  TextEditingController InitialDateController = TextEditingController();//
  TextEditingController FinalDateController = TextEditingController();//
  TextEditingController DenominacioController = TextEditingController();//
  TextEditingController UbicacioController = TextEditingController();//
  TextEditingController AdrecaController = TextEditingController();//
  TextEditingController EspaiController = TextEditingController();//
  TextEditingController DescripcioController = TextEditingController();//
  TextEditingController LatitudController = TextEditingController();//
  TextEditingController LongitudController = TextEditingController();//
  /** TextEditingController DataFiAproxController = TextEditingController();//
  TextEditingController EntradesController = TextEditingController();//
  TextEditingController HorariController = TextEditingController();//
  TextEditingController SubtitolController = TextEditingController();//
  TextEditingController LinkController = TextEditingController();//
  TextEditingController DocumentsController = TextEditingController();//
  TextEditingController VideoController = TextEditingController();//
  TextEditingController CodiPostalController = TextEditingController();//
  //TextEditingController ComarcaController = TextEditingController();
  TextEditingController EmailController = TextEditingController();//
  //TextEditingController LocalitatController = TextEditingController();
  TextEditingController TelefonController = TextEditingController();//
  TextEditingController URLController = TextEditingController();//
  TextEditingController AppImgController = TextEditingController();// **/

  @override
  Widget build(BuildContext context) {
    print("inicialitzacio correcta ");
    CodiController.text = event.codi!;
    InitialDateController.text = event.dataInici!;
    FinalDateController.text = event.dataFi!;
    DenominacioController.text = event.denominacio!;
    UbicacioController.text = event.ubicacio!;
    AdrecaController.text = event.adreca!;
    EspaiController.text = event.espai!;
    DescripcioController.text = event.descripcio!;
    LatitudController.text = (event.latitud!).toString();
    LongitudController.text = (event.longitud!).toString();
    //DataFiAproxController.text = event.dataFiAprox!;
    //EntradesController.text = event.entrades!;
    //HorariController.text = event.horari!;
    //SubtitolController.text = event.subtitol!;
    //LinkController.text = event.links!;
    //DocumentsController.text = event.documents!;
    //VideoController.text = event.videos!;
    //CodiPostalController.text = event.codiPostal!;
    //ComarcaController.text = event.comarcaIMunicipi!;
    //EmailController.text = event.email!;
    //LocalitatController.text = event.localitat!;
    //TelefonController.text = event.telf!;
    //URLController.text = event.URL!;
    //AppImgController.text = event.imgApp!;
    //List<String>? tagsAmbits = event.tagsAmbits!;
    //List<String>? tagsCateg = event.tagsCateg!;
    //List<String>? tagsAltresCateg = event.tagsAltresCateg!;
    //List<String>? imatges = event.imatges!;

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
                    title: Text(AppLocalizations.of(context)!.whatDoYouWant),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 40,
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                            title: Text(AppLocalizations.of(context)!.deleteEvent),
                                            content: Text(AppLocalizations.of(context)!.deleteQuestion),
                                            actions: <Widget>[
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    viewModel.deleteEventById(event.id!);
                                                    Navigator.pushNamed(
                                                        context, '/home');
                                                  },
                                                  child: Text(AppLocalizations.of(context)!.yes)
                                              ),

                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(AppLocalizations.of(context)!.no)
                                              ),
                                            ]
                                        ),
                                  );
                                },
                              ),

                              IconButton(
                                iconSize: 40,
                                icon: const Icon(Icons.cancel),
                                //color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                            title: Text(AppLocalizations.of(context)!.cancelEvent),
                                            content: Text(AppLocalizations.of(context)!.cancelQuestion),
                                            actions: <Widget>[
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    viewModel.putCancelledEventById(event.id!);
                                                    Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(event.id!));
                                                  },
                                                  child: Text(AppLocalizations.of(context)!.yes)
                                              ),

                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(AppLocalizations.of(context)!.no)
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
                            child: TextFormField(
                              controller: CodiController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.code,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: DenominacioController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.nameEventM,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          dataIni(),
                          dataFi(),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: UbicacioController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.location,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: AdrecaController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.address,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: EspaiController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.space,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: DescripcioController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.description,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: LatitudController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.latitude,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: LongitudController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)?.longitude,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            height: 70,
                              width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.orangeAccent)),
                              child: Text(AppLocalizations.of(context)!.modify),
                              onPressed: () {
                                event.id = event.id;
                                event.denominacio = DenominacioController.text;
                                event.codi = CodiController.text;
                                event.dataFi = FinalDateController.text;
                                event.dataInici = InitialDateController.text;
                                event.adreca = AdrecaController.text;
                                event.espai = EspaiController.text;
                                event.ubicacio = UbicacioController.text;
                                event.descripcio = DescripcioController.text;
                                event.latitud = double.parse(LatitudController.text);
                                event.longitud = double.parse(LongitudController.text);
                                viewModel.putEventById(event);
                                Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(event.id!));
                              },
                            ),
                          ),
                        ],
                      ),
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

class dataIni extends StatefulWidget {

  dataIni({super.key});

  @override
  State<dataIni> createState() => _dataIniState();
}

class _dataIniState extends State<dataIni> {
  String fecha = '';
  TextEditingController InitialDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: InitialDateController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: AppLocalizations.of(context)?.startDate,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.orangeAccent,
                width: 1.5
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          selectInitialDate(context);
        },
      ),
    );
  }

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
}

class dataFi extends StatefulWidget {

  dataFi({super.key});

  @override
  State<dataFi> createState() => _dataFiState();
}

class _dataFiState extends State<dataFi> {
  String fecha = '';
  TextEditingController FinalDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: FinalDateController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: AppLocalizations.of(context)?.finalDate,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.orangeAccent,
                width: 1.5
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(
              new FocusNode());
          selectFinalDate(context);
        },
      ),
    );
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