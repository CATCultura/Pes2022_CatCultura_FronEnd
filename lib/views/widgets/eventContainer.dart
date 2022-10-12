import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:provider/provider.dart';
import 'package:tryproject2/data/response/apiResponse.dart';
import 'package:tryproject2/viewModels/HomeViewModel.dart';

//import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/viewModels/EventContainerViewModel.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulEventContainer(),
    );
  }
}

class StatefulEventContainer extends StatefulWidget {
  const StatefulEventContainer({super.key});

  @override
  State<StatefulEventContainer> createState() => _StatefulEventContainerState();
}

class _StatefulEventContainerState extends State<StatefulEventContainer> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchEventsListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const height = 50.0; //= MediaQuery.of(context).size.height;
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (BuildContext context) => homeViewModel,
            child: Consumer<HomeViewModel>(builder: (context, value, _) {
              switch (value.eventsList.status) {
                case Status.LOADING:
                  return const SizedBox(
                    height: height,
                    child: Center(child: CircularProgressIndicator()),
                  );
                case Status.ERROR:
                  return Text(value.eventsList.toString());
                case Status.COMPLETED:
                  print("COMPLETEd");
                  return Text(homeViewModel.eventsList.data!.results![0].nom!.isEmpty ? "hola": homeViewModel.eventsList.data!.results![0].nom!);
                  //return ListItem(movies: value.upComingList.data!.results![index]);
                  /*return Column(children: [
                    const SizedBox(
                      height: height * .02,
                    ),
                    SizedBox(
                      height: height * .47,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            //padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 1.0),
                            child: Row(
                              children: [
                                //DATA-ESPAI-COMARCA
                                Expanded(
                                  flex: 4,
                                  child:
                                      Container(), //EventInfoShort(viewModel: homeViewModel),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10.0)),
                                //IMATGE
                                /*Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Image.network("")),
              ),*/
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Expanded(
                                        child:
                                            EventContainerPersonalizedTabs()),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ]);*/
                default:
                  return const Text("asdfasdf");
              }
            })),

        //PARTE 1

        //PARTE 2
      ],
    );
  }
}

class EventInfoShort extends StatelessWidget {
  const EventInfoShort({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EventContainerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 1.0, 8.0),
      margin: EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2.0),
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
              Text("${viewModel.dataInici} \n${viewModel.dataFi}"),
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
              getSizedText(viewModel.espai),
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
              getSizedText(viewModel.ComarcaMunicipi),
            ],
          ),
        ],
      ),
    );
  }
}

Widget getSizedText(String s) {
  print(s.length);
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
  const EventContainerPersonalizedTabs({super.key});

  @override
  State<EventContainerPersonalizedTabs> createState() =>
      _EventContainerPersonalizedTabsState();
}

class _EventContainerPersonalizedTabsState
    extends State<EventContainerPersonalizedTabs> {
  var viewModel = EventContainerViewModel();

  @override
  Widget build(BuildContext context) {
    final Tabs = <Widget>[
      const Tab(
        icon:
            Icon(Icons.info_outline, size: 20.0, color: MyColorsPalette.white),
        text: 'Info',
      ),
      const Tab(
          icon: Icon(Icons.hourglass_bottom,
              size: 20.0, color: MyColorsPalette.white),
          text: 'Data'),
      const Tab(
          icon: Icon(Icons.park_outlined,
              size: 20.0, color: MyColorsPalette.white),
          text: 'Espai')
    ];

    return DefaultTabController(
      length: Tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColorsPalette.red,
          title: Center(
            child: Text(
              viewModel.NomEvent,
              style: const TextStyle(
                  color: MyColorsPalette.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          bottom: TabBar(
            tabs: Tabs,
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                  child: Text(
                viewModel.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ),
            Text("${viewModel.dataInici}\n${viewModel.dataFi}"),
            Text("${viewModel.espai}\n${viewModel.ComarcaMunicipi}")
          ],
        ),
      ),
    );
  }
}
