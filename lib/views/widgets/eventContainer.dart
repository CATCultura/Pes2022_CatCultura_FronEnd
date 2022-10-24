import 'package:flutter/material.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/data/response/apiResponse.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';

//import 'package:tryproject2/constants/theme.dart';

//WIDGET EventContainet
class EventContainer extends StatefulWidget {

  //Aqui les variables
  String eventId;
    //Declarem el viewModel que li arriba desde la pàgina que el crida
  final EventsViewModel viewModel;

  //La key (demanem required this.viewModel)
  EventContainer({super.key, required this.eventId, required this.viewModel});

  @override
  State<EventContainer> createState() => _EventContainerState();
}

class _EventContainerState extends State<EventContainer> {
  late EventsViewModel viewModel = widget.viewModel;
  late String eventId = widget.eventId;

  @override
  void initState() {
    viewModel.eventSelected.status = Status.LOADING;
    viewModel.selectEventById(eventId);
    print("iniStateEventContianer");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
       switch (viewModel.eventSelected.status) {
                case Status.LOADING:
                  return SizedBox(
                    height: height,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                case Status.ERROR:
                  return Text(viewModel.eventSelected.toString());
                case Status.COMPLETED:
                  return  Column(
                          children: [
                            Expanded(
                              flex: 2,
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 1.0),
                              child: Row(
                                children: [
                                  //DATA-ESPAI-COMARCA
                                  Expanded(
                                    //flex: 4,
                                    child:
                                        EventInfoShort(viewModel: viewModel),
                                  ),
                                  //const Padding(padding: EdgeInsets.only(left: 10.0)),
                                ],
                              ),
                            ),
                            //const Padding(padding: EdgeInsets.only(top: 100.0)),
                            Expanded(
                              flex: 3,
                              child:Container(
                                  decoration: const BoxDecoration(
                                    // border: Border(
                                    //   top: BorderSide(
                                    //     color: Colors.grey,
                                    //     style: BorderStyle.solid,
                                    //     width: 3,
                                    //   ),
                                    // ),
                                  ),
                                  //padding: const EdgeInsets.only(top:25.0),
                                  //margin: const EdgeInsets.only(top: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: EventContainerPersonalizedTabs(viewModel: viewModel)),
                                    ],
                                  )),
                            ),
                          ],
                        );

                default:
                  return const Text("asdfasdf");
              }

  }
}

class EventInfoShort extends StatelessWidget {
  const EventInfoShort({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EventsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //PARTE 1
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: [
              //DATA-ESPAI-COMARCA
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0, ),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: MyColorsPalette.red,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 16)),
                          getSizedText("${viewModel.eventSelected.data!.dataInici} \n${viewModel.eventSelected.data!.dataFi}"),
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
                          getSizedText(viewModel.eventSelected.data!.denominacio!),
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
                          getSizedText(viewModel.eventSelected.data!.comarcaIMunicipi!),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left:10,),),
              //IMATGE
              Expanded(
                flex: 3,
                child: SizedBox(
                  //height: 1,
                    child: Image.network(viewModel.eventSelected.data!.imatges!)),
              ),
            ],
          ),
        ),
      ],
    );
     }
}

Widget getSizedText(String s) {
  print(s.length);
  TextStyle t;
  if (s.length <= 54) {
    return Flexible(child: Text(s));
  } else {
    return Flexible(
        child: Text(
      s,
      overflow: TextOverflow.ellipsis,
    ));
  }
}

class EventContainerPersonalizedTabs extends StatefulWidget {
  final EventsViewModel? viewModel;
  const EventContainerPersonalizedTabs({super.key, this.viewModel});

  @override
  State<EventContainerPersonalizedTabs> createState() =>
      _EventContainerPersonalizedTabsState();
}

class _EventContainerPersonalizedTabsState extends State<EventContainerPersonalizedTabs> {
    late EventsViewModel? viewModel =  widget.viewModel;
    bool Favorit = false;
    bool assistire = false;

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
          text: 'Espai'),
      IconButton(
          padding: const EdgeInsets.only(bottom: 5.0),
          iconSize: 40,
          icon: Icon((assistire == false) ? Icons.flag_outlined : Icons.flag, color: MyColorsPalette.white),
          onPressed: (){
            setState(() {
              assistire = !assistire;
            });
          },
      ),
      IconButton(
          padding: const EdgeInsets.only(bottom: 5.0),
          iconSize: 40,
          icon: Icon((Favorit == false) ? Icons.star_border_outlined : Icons.star, color: MyColorsPalette.white),
          onPressed: (){
            setState(() {
              Favorit = !Favorit;
            });
          },
        ),
    ];
    return DefaultTabController(
      length: Tabs.length-2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: MyColorsPalette.red,
            title: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  viewModel!.eventSelected.data!.denominacio!,
                    overflow: TextOverflow.clip,
                  style: const TextStyle(color: MyColorsPalette.white,
                       fontWeight: FontWeight.bold, ),
                ),
              ),
            ),
            bottom: TabBar(
              tabs: Tabs,
            ),
          ),
        ),
        body: TabBarView(
          children:[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(child:Text(viewModel!.eventSelected.data!.descripcio!, textAlign: TextAlign.justify,style: TextStyle(fontSize: 20, ),),),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("${viewModel!.eventSelected.data!.dataInici}\n${viewModel!.eventSelected.data!.dataFi}"),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("${viewModel!.eventSelected.data!.localitat!}\n${viewModel!.eventSelected.data!.comarcaIMunicipi!}"),
            )
          ],
        ),
      ),
    );
  }
}

