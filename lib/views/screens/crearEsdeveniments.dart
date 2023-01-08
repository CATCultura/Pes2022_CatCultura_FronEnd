// import 'dart:ffi';

import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final _formKey = GlobalKey<FormState>();

  String fecha = '';
  TextEditingController CodiController = TextEditingController();
  TextEditingController InitialDateController = TextEditingController();
  TextEditingController FinalDateController = TextEditingController();
  TextEditingController DenominacioController = TextEditingController();
  TextEditingController UbicacioController = TextEditingController();
  TextEditingController AdrecaController = TextEditingController();
  TextEditingController EspaiController = TextEditingController();
  TextEditingController DescripcioController = TextEditingController();
  TextEditingController LatitudController = TextEditingController();
  TextEditingController LongitudController = TextEditingController();
  TextEditingController DataFiAproxController = TextEditingController();
  TextEditingController EntradesController = TextEditingController();
  TextEditingController HorariController = TextEditingController();
  TextEditingController SubtitolController = TextEditingController();
  TextEditingController LinkController = TextEditingController();
  TextEditingController DocumentsController = TextEditingController();
  TextEditingController VideoController = TextEditingController();
  TextEditingController CodiPostalController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TelefonController = TextEditingController();
  TextEditingController URLController = TextEditingController();
  TextEditingController AppImgController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                  title: Text(AppLocalizations.of(context)!.createEventDrawer),
                  backgroundColor: MyColorsPalette.orange,
                ),
                drawer: MyDrawer(AppLocalizations.of(context)!.createEventDrawer,  Session(), username: "Superjuane",
                  email: "juaneolivan@gmail.com"),
                body: SingleChildScrollView(
                  child: SizedBox(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //attributes("Codi"),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: CodiController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.codeEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                enableInteractiveSelection: false,
                                controller: InitialDateController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.startDateEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                enableInteractiveSelection: false,
                                controller: FinalDateController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.finalDateEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: DenominacioController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.nameEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: UbicacioController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.locationEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: AdrecaController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.addressEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: EspaiController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.spaceEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: DescripcioController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.descriptionEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: LatitudController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.latitudeEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                validator: (value) {
                                  if (value!.isEmpty) return "Obligatori";
                                },
                                controller: LongitudController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.longitudeEvent,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: DataFiAproxController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.approximateEndDate,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: EntradesController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.ticket,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: HorariController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.schedule,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: SubtitolController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.subtitle,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: LinkController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.links,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: DocumentsController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.documents,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: VideoController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.video,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: CodiPostalController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.postalCode,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: EmailController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.email,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: TelefonController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.telephone,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: URLController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.url,
                                  enabledBorder: const OutlineInputBorder(
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
                                controller: AppImgController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: AppLocalizations.of(context)?.imageApp,
                                  enabledBorder: const OutlineInputBorder(
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
                                child: Text(AppLocalizations.of(context)!.createEvent),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Validació exitosa");

                                    EventResult? e = EventResult();
                                    e.codi = CodiController.text;
                                    e.denominacio = DenominacioController.text;
                                    e.dataInici = InitialDateController.text;
                                    e.dataFi = FinalDateController.text;
                                    e.ubicacio = UbicacioController.text;
                                    e.adreca = AdrecaController.text;
                                    e.espai = EspaiController.text;
                                    e.descripcio = DescripcioController.text;
                                    e.latitud = double.parse(LatitudController.text);
                                    e.longitud = double.parse(LongitudController.text);
                                    e.dataFiAprox = DataFiAproxController.text;
                                    e.entrades = EntradesController.text;
                                    e.horari = HorariController.text;
                                    e.subtitol = SubtitolController.text;
                                    e.links = LinkController.text;
                                    e.documents = DocumentsController.text;
                                    e.videos = VideoController.text;
                                    e.codiPostal = CodiPostalController.text;
                                    e.email = EmailController.text;
                                    e.telf = TelefonController.text;
                                    e.URL = URLController.text;
                                    e.imgApp = AppImgController.text;
                                    e.tagsAmbits = [];
                                    e.tagsCateg = [];
                                    e.tagsAltresCateg = [];
                                    e.imatges = [];
                                    viewModel.crearEvent(e);
                                    Navigator.popAndPushNamed(context, '/home');
                                  }
                                  else {
                                    print("Hi ha algun error, revisi els camp obligatoris");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : viewModel.eventsList.status == Status.LOADING? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
              )
                  : viewModel.eventsList.status == Status.ERROR? Text(viewModel.eventsList.toString())
                  : viewModel.eventsList.status == Status.COMPLETED? EventCreat(): Text ("Esdeveniment creat")
            ),
          );
        }));
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





