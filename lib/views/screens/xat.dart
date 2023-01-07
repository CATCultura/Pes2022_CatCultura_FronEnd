//import 'dart:html';

import 'package:CatCultura/repository/ChatRepository.dart';
import 'package:CatCultura/views/widgets/errorWidget.dart';
import  'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../models/Message.dart';
import '../../providers/xat.dart';
import '../../utils/Session.dart';
import '../../viewModels/ChatViewModel.dart';
import '../widgets/myDrawer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Xat extends StatefulWidget {
  final String eventId;
  Xat(this.eventId, {super.key});
  // final ChatViewModel viewModel = ChatViewModel();

  @override
  State<Xat> createState() => _xatState();
}

class _xatState extends State<Xat> {
  late String eventId = widget.eventId;
  late ChatViewModel viewModel;



  final TextEditingController _messageInputController = TextEditingController();


  @override
  void initState() {
    super.initState();
    viewModel = ChatRepository().getSubscriber(eventId) ?? ChatViewModel(eventId);
    viewModel.fetchMessages();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ChatViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ChatViewModel>(builder: (context, value, _) {
          return Scaffold(
              appBar: AppBar(
                    title: const Text("Xat"),
                    backgroundColor: MyColorsPalette.orange,
                  ),
            drawer: MyDrawer("xat", Session()),
            body: viewModel.eventChatMessages.status == Status.LOADING ? const SizedBox(
              child: Center(
                  child: CircularProgressIndicator()
              ),
            )
                : viewModel.eventChatMessages.status == Status.ERROR ? Text(viewModel.eventChatMessages.toString())
                : viewModel.eventChatMessages.status == Status.COMPLETED ?
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                      itemCount: viewModel
                          .eventChatMessages
                          .data!
                          .length,
                      itemBuilder:
                          (BuildContext context,
                          int i) {
                        return Wrap(
                          crossAxisAlignment: viewModel.eventChatMessages.data![i].userId == Session().data.id.toString()
                            ? WrapCrossAlignment.end
                          : WrapCrossAlignment.start,
                          alignment: viewModel.eventChatMessages.data![i].userId == Session().data.id.toString()
                              ? WrapAlignment.end
                              : WrapAlignment.start,
                          children: [
                              Card(
                                color: viewModel.eventChatMessages.data![i].userId == Session().data.id.toString()
                                    ? Theme.of(context).primaryColorLight
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                      viewModel.eventChatMessages.data![i].userId == Session().data.id.toString()
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(viewModel.eventChatMessages.data![i].username),
                                      Text(viewModel.eventChatMessages.data![i].content),
                                      Text(
                                        viewModel.eventChatMessages.data![i].timeSent,
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                      }),
                ),
                    SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageInputController,
                              decoration: const InputDecoration(
                                hintText: 'Escriu el missatge aqui',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_messageInputController.text.trim().isNotEmpty) {
                                viewModel.sendMessage(_messageInputController.text.trim());
                                _messageInputController.clear();
                              }
                            },
                            icon: const Icon(Icons.send),
                          )
                        ],
                      )
                    )
              ],
            ) : const CustomErrorWidget(),
          );
        },
        )
    );

    // return ChangeNotifierProvider<ChatViewModel>(
    //   create: (BuildContext context) => viewModel,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Xat"),
    //       backgroundColor: MyColorsPalette.orange,
    //     ),
    //     drawer: MyDrawer("Xat", Session(), username: "Superjuane",
    //         email: "juaneolivan@gmail.com"),
    //     body:
    //     viewModel.eventChatMessages.status ==
    //         Status.LOADING
    //         ? const SizedBox(
    //       child: Center(
    //           child: CircularProgressIndicator()),
    //     )
    //         : viewModel.eventChatMessages.status == Status.ERROR
    //         ? Text(viewModel.eventChatMessages.toString())
    //         : viewModel.eventChatMessages.status ==
    //         Status.COMPLETED ? Column(
    //       children: [
    //         Expanded(
    //           child: Consumer<ChatViewModel>(
    //             builder: (_, provider, __) => ListView.builder(
    //               padding: const EdgeInsets.all(16),
    //                 itemCount: viewModel
    //                     .eventChatMessages
    //                     .data!
    //                     .length,
    //
    //               itemBuilder: (context, index) {
    //                 return  Wrap(
    //                   children: [
    //                     Card(
    //                       // color: message.senderUsername == "admin"
    //                       //     ? Theme.of(context).primaryColorLight
    //                       //     : Colors.white,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           // crossAxisAlignment:
    //                           //   message.senderUsername == "admin"
    //                           //     ? CrossAxisAlignment.end
    //                           //     : CrossAxisAlignment.start,
    //                           children: [
    //                             Text(viewModel.eventChatMessages.data![index].content),
    //                             Text(
    //                               viewModel.eventChatMessages.data![index].timeSent,
    //                               style: Theme.of(context).textTheme.caption,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //             color: Colors.grey.shade200,
    //           ),
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           child: SafeArea(
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: TextField(
    //                     controller: _messageInputController,
    //                     decoration: const InputDecoration(
    //                       hintText: 'Escriu el missatge aqui',
    //                       border: InputBorder.none,
    //                     ),
    //                   ),
    //                 ),
    //                 IconButton(
    //                   onPressed: () {
    //                     if (_messageInputController.text.trim().isNotEmpty) {
    //                       _sendMessage();
    //                     }
    //                   },
    //                   icon: const Icon(Icons.send),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ) : const CustomErrorWidget(),
    //   ),
    // );
  }
}