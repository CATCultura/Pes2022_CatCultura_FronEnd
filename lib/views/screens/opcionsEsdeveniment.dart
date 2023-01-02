import 'package:CatCultura/utils/routes/allScreens.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/shared.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/models/EventResult.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../widgets/events/eventInfoShort.dart';


class opcionsEsdeveniment extends StatelessWidget {
  opcionsEsdeveniment({super.key, required this.event});
  EventResult event;

  /*+@override
  State<opcionsEsdeveniment> createState() => _opcionsState(); **/

//}

//class _opcionsState extends State<opcionsEsdeveniment> {
  final EventUnicViewModel viewModel = EventUnicViewModel();
  String fecha = '';
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

    print(event.id!);
    print(CodiController.text);
    print("DATES:");
    print(InitialDateController.text);
    print(FinalDateController.text);
    print(DenominacioController.text);
    print(UbicacioController.text);
    print(AdrecaController.text);
    print(EspaiController.text);
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
                                                    viewModel.deleteEventById(event.id!);
                                                    Navigator.pushNamed(
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
                                                    viewModel.putCancelledEventById("3233");
                                                    Navigator.pushNamed(context, '/eventUnic', arguments: EventUnicArgs(event.id!));
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
                            child: TextFormField(
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

                          dataIni(),
                          dataFi(),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
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
                            child: TextFormField(
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
                            child: TextFormField(
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: DescripcioController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Descripció',
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
                            child: TextFormField(
                              controller: LatitudController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Latitud',
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
                            child: TextFormField(
                              controller: LongitudController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Longitud (Obligatori)',
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
                              child: const Text('Modificar'),
                              onPressed: () {
                                print(event.id!);
                                print(CodiController.text);
                                print("DATES:");
                                print(InitialDateController.text);
                                print(FinalDateController.text);
                                print(DenominacioController.text);
                                print(UbicacioController.text);
                                print(AdrecaController.text);
                                print(EspaiController.text);
                                print(event.horari);

                                event.id = "3522"; //event.id;
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
                                /** event.dataFiAprox = "dema"; //DataFiAproxController.text;
                                event.entrades = EntradesController.text;
                                event.horari = HorariController.text;
                                event.subtitol = SubtitolController.text;
                                event.links = LinkController.text;
                                event.documents = DocumentsController.text;
                                event.videos = VideoController.text;
                                event.codiPostal = CodiPostalController.text;
                                //e.comarcaIMunicipi = ComarcaController.text;
                                event.email = EmailController.text;
                                //e.localitat = LocalitatController.text;
                                event.telf = TelefonController.text;
                                event.URL = URLController.text;
                                event.imgApp = AppImgController.text;
                                event.cancelado = false;
                                //e.tagsCateg = tagsAmbits;
                                //e.tagsCateg = tagsCateg;
                                //e.tagsAltresCateg = tagsAltresCateg;
                                //e.imatges = imatges; **/
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

  selectFinalDate(BuildContext context) async {
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

  void setState(Null Function() param0) {}

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