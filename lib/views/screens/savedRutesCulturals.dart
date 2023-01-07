import 'dart:ui';

import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';
import '../../viewModels/SavedRutesCulturalsViewModel.dart';
import '../widgets/events/eventInfoTile.dart';

class SavedRutesCulturals extends StatefulWidget {
  const SavedRutesCulturals({super.key});

  @override
  SavedRutesCulturalsState createState() => SavedRutesCulturalsState();
}

class SavedRutesCulturalsState extends State<SavedRutesCulturals> {
  SavedRutesCulturalsViewModel viewModel = SavedRutesCulturalsViewModel();

  @override
  void initState() {
    viewModel.getSavedRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedRutesCulturalsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<SavedRutesCulturalsViewModel>(
            builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.lightBlue),
            ),
            body: Center(
              child: viewModel.routeList.status == Status.LOADING
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : viewModel.routeList.status == Status.ERROR
                      ? Text(viewModel.routeList.toString())
                      : viewModel.routeList.status == Status.COMPLETED
                          ? Column(
                              children: [
                                viewModel.routeList.data!.length > 0? Expanded(
                                  child: ListView.builder(
                                      // controller:
                                      // _scrollController,
                                      itemCount:
                                          viewModel.routeList.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(top:8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(viewModel.routeList.data![i].name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                                                      //Text(viewModel.routeList.data![i].id!, style: TextStyle(fontSize: 7, color: Colors.grey ),)
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          IconButton(onPressed: () async {
                                                            viewModel.shareEvent(viewModel.routeList.data![i].id!);
                                                          },
                                                            icon: Icon(Icons.share_rounded), iconSize: 35, ),
                                                          Ink(
                                                            width: 30,
                                                            decoration: const ShapeDecoration(
                                                              color: Colors.red,
                                                              shape: CircleBorder(),
                                                            ),
                                                            child: IconButton(
                                                              iconSize: 15,
                                                              icon: const Icon(Icons.close),
                                                              color: Colors.white,
                                                              onPressed: () {
                                                                showDialog(context: context, builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text("Eliminar ruta cultural"),
                                                                    content: const Text("¿Estás seguro de que quieres eliminar esta ruta cultural?"),
                                                                    actions: [
                                                                      TextButton(onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      }, child: const Text("Cancelar")),
                                                                      TextButton(onPressed: () {
                                                                        viewModel.deleteRoute(viewModel.routeList.data![i].id!);
                                                                        Navigator.of(context).pop();
                                                                      }, child: const Text("Eliminar"))
                                                                    ],
                                                                  );
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(viewModel.routeList.data![i].description!, style: TextStyle(fontSize: 15, color: Colors.grey ),),
                                                  Divider(),
                                                ],
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.pop(context, RutaCulturalLoadArgs(viewModel.routeList.data![i].events));
                                            },
                                        );
                                        //   EventInfoTile(
                                        //   event: viewModel.routeList.data![i],
                                        //   index: i,
                                        // );
                                      }),
                                ):
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:35.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text("😢", style: TextStyle(fontSize: 50),),
                                        const SizedBox(height: 20,),
                                        const Text("No tienes ninguna ruta cultural guardada", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                        const Text("Genera una ruta y guardala", style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text("asdfasdf"),
            ),
          );
        }));
  }
}
