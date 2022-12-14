//import 'dart:html';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:CatCultura/views/screens/qrScanning.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:CatCultura/views/screens/singleEventMap.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/views/widgets/events/reviewCard.dart';
//import 'package:CatCultura/views/widgets/datePickerWidget.dart';
//imports per compartir els events.
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

//import per els idiomes
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//imports per notificacions
import 'package:flutter/cupertino.dart';

import 'package:CatCultura/notifications/notificationService.dart';

import 'dart:math' as math;

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../models/ReviewResult.dart';
import '../../utils/Session.dart';
import '../widgets/cards/organizerCard.dart';

const backgroundcolor = Color(0xffFBFBFB);

class EventUnic extends StatefulWidget {
  EventUnic({super.key, required this.eventId});
  String eventId;
  EventUnicViewModel viewModel = EventUnicViewModel();

  @override
  State<EventUnic> createState() => _EventUnicState();
}

class _EventUnicState extends State<EventUnic> {
  late String eventId = widget.eventId;
  late EventUnicViewModel viewModel = widget.viewModel;

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("_actionTitles[index]"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    viewModel.ini();
    viewModel.selectEventById(eventId);
    if (Session().data.role=="ADMIN") viewModel.getAttendanceCode(eventId);
    print("L'id de l'esdeveniment es: ");
    print(eventId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<EventUnicViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
          return viewModel.eventSelected.status == Status.LOADING ?
          SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator()),
                      ) :
          Scaffold(
            // floatingActionButton: ExpandableFab(
            //   distance: 100.0,
            //   children: [
            //     ActionButton(
            //       onPressed: () => () {
            //         if(viewModel.favorit){
            //           setState(() {
            //             viewModel.favorit = false;
            //           });
            //           debugPrint("puesto en falso");
            //         }
            //         else{
            //           setState(() {
            //             viewModel.favorit = true;
            //           });
            //           debugPrint("puesto en true");
            //         }
            //       },
            //       icon: viewModel.favorit? Icon(Icons.star) :  Icon(Icons.star_outline),
            //     ),
            //     ActionButton(
            //       onPressed: () => _showAction(context, 1),
            //       icon: const Icon(Icons.insert_photo),
            //     ),
            //     ActionButton(
            //       onPressed: () => _showAction(context, 2),
            //       icon: const Icon(Icons.videocam),
            //     ),
            //   ],
            // ),

            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _AppBarNetflix(
                    minExtended: kToolbarHeight,
                    maxExtended: size.height * 0.35,
                    size: size,
                    event: viewModel.eventSelected.data!,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Body( event: viewModel.eventSelected.data!,size: size,
                      date: viewModel.eventSelected.data!.dataInici!+"\n"+viewModel.eventSelected.data!.dataFi!,
                      place: viewModel.eventSelected.data!.espai! +" -\n"+viewModel.eventSelected.data!.comarcaIMunicipi!,
                      // place: viewModel.eventSelected.data!.u!
                      descripcio: viewModel.eventSelected.data!.descripcio!, viewModel: viewModel
                  ),
                )
              ],
            ),
          );
        }));
  }
}

class _AppBarNetflix extends SliverPersistentHeaderDelegate {
  const _AppBarNetflix({
    required this.maxExtended,
    required this.minExtended,
    required this.size,
    required this.event,
  });
  final double maxExtended;
  final double minExtended;
  final Size size;
  final EventResult event;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxExtended;
    //validate the angle at which the card returns
    const uploadlimit = 13 / 100;
    //return value of the card
    final valueback = (1 - percent - 0.77).clamp(0, uploadlimit);
    final fixrotation = pow(percent, 1.5);

    final card = Portada(
      size: size,
      percent: percent,
      uploadlimit: uploadlimit,
      valueback: valueback,
      imgUrl: "https://agenda.cultura.gencat.cat/"+event.imatges![0],
    );

    final bottomsliverbar = _CustomBottomSliverBar(
      size: size,
      fixrotation: fixrotation,
      percent: percent,
      title: event.denominacio!
    );

    return Stack(
      children: [
        BackgroundSliver(imgUrl: "https://agenda.cultura.gencat.cat/"+event.imgApp!,),
        if (percent > uploadlimit) ...[
          card,
          bottomsliverbar,
        ] else ...[
          bottomsliverbar,
          card,
        ],
        ButtonBack(
          size: size,
          percent: percent,
          onTap: () => Navigator.pop(context),
        ),
        //FavoriteCircle(size: size, percent: percent)
      ],
    );
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class Portada extends StatelessWidget {
  const Portada({
    Key? key,
    required this.size,
    required this.percent,
    required this.uploadlimit,
    required this.valueback,
    required this.imgUrl,
  }) : super(key: key);
  final Size size;
  final double percent;
  final double uploadlimit;
  final num valueback;
  final String imgUrl;

  final double angleForCard = 6.5;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.15,
      left: size.width / 24,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(percent > uploadlimit
              ? (valueback * angleForCard)
              : percent * angleForCard),
        child: CoverPhoto(size: size, imgUrl: imgUrl),
      ),
    );
  }
}

class _CustomBottomSliverBar extends StatelessWidget {
  const _CustomBottomSliverBar({
    Key? key,
    required this.size,
    required this.fixrotation,
    required this.percent,
    required this.title,
  }) : super(key: key);
  final Size size;
  final num fixrotation;
  final double percent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: -size.width * fixrotation.clamp(0, 0.35),
        right: 0,
        child: _CustomBottomSliver(
          size: size,
          percent: percent,
          title: title,
        ));
  }
}

class _CustomBottomSliver extends StatelessWidget {
  const _CustomBottomSliver({
    Key? key,
    required this.size,
    required this.percent,
    required this.title,
  }) : super(key: key);

  final Size size;
  final double percent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.12,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: CutRectangle(),
          ),
          DataCutRectangle(
            size: size,
            percent: percent,
            title: title,
          )
        ],
      ),
    );
  }
}

// class FavoriteCircle extends StatelessWidget {
//   const FavoriteCircle({
//     Key? key,
//     required this.size,
//     required this.percent,
//   }) : super(key: key);
//   final Size size;
//   final double percent;
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: size.height * 0.10,
//       right: 10,
//       child: percent < 0.2
//           ? TweenAnimationBuilder<double>(
//               tween: percent < 0.17
//                   ? Tween(begin: 1, end: 0)
//                   : Tween(begin: 0, end: 1),
//               duration: const Duration(milliseconds: 300),
//               builder: (context, value, widget) {
//                 return Transform.scale(
//                   scale: 1.0 - value,
//                   child: CircleAvatar(
//                     minRadius: 20,
//                     backgroundColor: Colors.red[300],
//                     child: Icon(
//                       Icons.favorite,
//                       color: Colors.red[900],
//                     ),
//                   ),
//                 );
//               })
//           : const SizedBox(),
//     );
//   }
// }

class BackgroundSliver extends StatelessWidget {
  const BackgroundSliver({
    Key? key, required this.imgUrl,
  }) : super(key: key);

  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: Image(
        image: NetworkImage(
            imgUrl!),
        fit: BoxFit.cover,
      ),
    );
  }
}
class Body extends StatefulWidget {
  Body({super.key, required this.size,
    required this.date,
    required this.place,
    required this.descripcio,
    required this.viewModel,
    required this.event,});

 final EventResult event;
  final Size size;
  final String date;
  final String place;
  final String descripcio;
  final EventUnicViewModel viewModel;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
// class Body extends StatelessWidget {
//   const Body({
//     Key? key,
//     required this.size,
//     required this.date,
//     required this.place,
//     required this.descripcio,
//     required this.viewModel,
//     required this.event,
//   }) : super(key: key);

  late EventResult event = widget.event;
  late Size size = widget.size;
  late String date = widget.date;
  late String place = widget.place;
  late String descripcio = widget.descripcio;
  late EventUnicViewModel viewModel = widget.viewModel;
  final GlobalKey _globalKey = GlobalKey();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectedDate(BuildContext context) async{
    DateTime currentTime = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015,8),
      lastDate: DateTime(2101),
    );
    if(picked != null && picked != selectedDate) setState(() {
      selectedDate = picked;
    });

    final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: selectedTime);
    if(pickedTime != null && pickedTime != selectedTime) setState(() {
      selectedTime = pickedTime;
    });
    DateTime newDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    if(newDateTime.isBefore(currentTime)){
      _showErrorDialog(context, AppLocalizations.of(context)!.errorAddAttendance);
    }

    String titolEv = viewModel.eventSelected.data!.denominacio as String;
    NotificationService().showScheduledNotifications( viewModel.eventSelected.data!.id, "CATCultura", titolEv, selectedDate, selectedTime); //widget.callback!("addAttendance");
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            CupertinoButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget nothing() {
    return const SizedBox(width: 0, height: 0);
  }

   Future<void> _navigateAndCaptureQR(
      BuildContext context) async {
    setState(() {
      viewModel.wrongCode = false;
    });
    Navigator.pop(context);
    final result = await Navigator.push(
      context,
      MaterialPageRoute<QrCodeArgs>(
          builder: (context) => QRScanning(event.id!)),
    );
    viewModel.confirmAttendance(result!.code, event.id!);



    //viewModel.paintRoute();
    // setState(() {
    //
    // });
  }



  Widget showAttendanceDialog(bool attended) {
    if (!attended) {
      TextEditingController controller = TextEditingController();
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.exitButton)),
          ElevatedButton(onPressed: () =>
          {
            viewModel.confirmAttendance(controller.text, event.id),
            Navigator.pop(context)
          } ,
            child:Text(AppLocalizations.of(context)!.sendAttendanceCodeButton),

          ),
          ElevatedButton(onPressed: () =>
          {
            _navigateAndCaptureQR(context),
          }, child: Text(AppLocalizations.of(context)!.scanQRCodeButton)),
        ],
        title: Text(AppLocalizations.of(context)!.confirmAttendanceDialogTitle),
        content: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height / 6,
          child: Column(
            children: [
              Text(
                  AppLocalizations.of(context)!.explanationForAttendanceCodeInput),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterCodeHintText,
                    hintStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    )
                ),

              )
            ],
          ),
        ),
      );
    }
      else {
      return AlertDialog(
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.okButton)),
        ],
        title: Text(AppLocalizations.of(context)!.attendanceAlreadyConfirmed),
      );
    }
  }

  Future<void> captureWidget() async {
    // (context.findRenderObject()! as OffsetLayer).to
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // boundary = (boundary.child as RenderPadding).;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    setState(() {

    });
    await viewModel.shareQrImage("QR", pngBytes);

    // return pngBytes;
  }


  @override
  Widget build(BuildContext context) {
    // if (viewModel.wrongCode) {
    //   showDialog(context: context, builder: (BuildContext context)
    //   {
    //     return showWrongCodeDialog();
    //   });
    //
    // }
    return Container(
        padding: const EdgeInsets.only(top: 10),
        color: backgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          if (viewModel.wrongCode) Card(
            color: Colors.white38,
            elevation: 5.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.wrongAttendanceCode, style: TextStyle(color: Colors.red),),
                TextButton(onPressed: () => viewModel.setWrongCode(false), child: Text("ok"))],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              /*
              void treatCallback(String value){
                if(value== "addAttendance") {viewModel.putAttendanceById(loggedUserId, eventId);}
                else if(value == "deleteAttendance") viewModel.deleteAttendanceById(loggedUserId, eventId);
                else if(value == "addFavourite"){ viewModel.putFavouriteById(loggedUserId, eventId);
                }
                else if(value == "deleteFavourite") viewModel.deleteFavouriteById(loggedUserId, eventId);
              }
               */
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (Session().data.role == "ADMIN" && viewModel.attendanceCode.status == Status.COMPLETED) Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 40,
                            icon: const Icon(Icons.qr_code), color: const Color(0xF4C20606),
                            onPressed: () {
                              showDialog(context: context,
                              barrierDismissible: true,
                              builder: (BuildContext) {
                                return RepaintBoundary(
                                  key: _globalKey,
                                  child: AlertDialog(
                                  content: GestureDetector(
                                    onLongPress: () => {
                                      debugPrint("hola"),
                                      captureWidget()
                                    },
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          QrImage(
                                            data: viewModel.attendanceCode.data!,
                                            version: QrVersions.auto,
                                            size: 350.0,
                                          ),
                                          Card(child: Text(AppLocalizations.of(context)!.scanMeQR, style: TextStyle(fontSize: 15),))
                                        ],
                                      ),
                                    ),
                                  ),
                                  ),
                                );
                              }
                              );
                            },
                          ),
                          Text(AppLocalizations.of(context)!.generateQRbutton, style: TextStyle(fontSize: 12 ,color: Color(0xF4C20606)),),
                        ],
                      ),
                      if (viewModel.isOrganizer) IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.settings), color: Color(0xF4C20606),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, '/opcions-Esdeveniment',
                              arguments: EventArgs(viewModel.eventSelected.data!));
                          },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 40,
                            icon: Icon(Icons.calendar_month), color: Color(0xF4C20606),
                            onPressed: () {
                              viewModel.addToCalendar(viewModel.eventSelected.data!.denominacio,
                                  viewModel.eventSelected.data!.dataInici, viewModel.eventSelected.data!.dataInici,
                                  viewModel.eventSelected.data!.localitat, viewModel.eventSelected.data!.descripcio);
                            },
                          ),
                          Text(AppLocalizations.of(context)!.exportToCalendarButton, style: TextStyle(fontSize: 12 ,color: Color(0xF4C20606)),),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            iconSize: 40,
                            icon: Icon(Icons.share_rounded), color: Color(0xF4C20606),
                            onPressed: () async {
                              final imgUrl = "https://agenda.cultura.gencat.cat/"+event.imatges![0];
                              final titol = event.denominacio;
                              viewModel.shareEvent(imgUrl, titol);
                            },
                          ),
                          Text(AppLocalizations.of(context)!.shareEvent, style: TextStyle(fontSize: 12, color: Color(0xF4C20606)),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              viewModel.isUser ? Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        // padding: const EdgeInsets.only(bottom: 5.0),
                        iconSize: 40,
                        icon: Icon(Session().data.attendedId!.contains(int.parse(event.id!))
                            ? Icons.confirmation_number
                            : Icons.confirmation_num_outlined, color: Color(0xF4C20606)),
                        onPressed: () {
                          showDialog(context: context,
                            barrierDismissible: true,
                            builder: (BuildContext) {
                              return showAttendanceDialog(Session().data.attendedId!.contains(int.parse(event.id!)));
                            }
                        );
                        },
                      ),
                      Text(AppLocalizations.of(context)!.confirmAttendanceMenuOption, softWrap: true, style: const TextStyle(fontSize: 12 ,color: Color(0xF4C20606),),),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        // padding: const EdgeInsets.only(bottom: 5.0),
                        iconSize: 40,
                        icon: Icon((viewModel.agenda == false) ? Icons.flag_outlined : Icons.flag, color: Color(0xF4C20606)),
                        onPressed: (){
                          if(viewModel.agenda == true) {
                            viewModel.deleteAttendanceById(viewModel.eventSelected.data!.id);
                            //widget.callback!("deleteAttendance");
                            NotificationService().deleteOneNotification(viewModel.eventSelected.data!.id);
                          }
                          else {
                            _selectedDate(context);
                            viewModel.putAttendanceById(viewModel.eventSelected.data!.id);
                          }
                        },
                      ),
                      Text(AppLocalizations.of(context)!.agendaTitle, style: TextStyle(fontSize: 12 ,color: Color(0xF4C20606)),),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        // padding: const EdgeInsets.only(bottom: 5.0),
                        iconSize: 40,
                        icon: Icon((viewModel.favorit == false) ? Icons.star_border_outlined : Icons.star,color: Color(0xF4C20606)),
                        onPressed: (){
                          if(viewModel.favorit == true){
                            viewModel.deleteFavouriteById(viewModel.eventSelected.data!.id);
                            // widget.callback!("deleteFavourite");
                          }
                          else{
                            viewModel.putFavouriteById(viewModel.eventSelected.data!.id);
                            // widget.callback!("addFavourite");
                          }
                        },
                      ),
                      Text(AppLocalizations.of(context)!.favouritesTitle, style: TextStyle(fontSize: 12 ,color: Color(0xF4C20606)),),
                    ],
                  ),
                ],
              ) : nothing(),

            ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left:22.0, right: 22.0),
              child: Divider(thickness: 2,),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                _CustomIcon(
                  icon: Icons.calendar_month,
                  text: date,
                  onTap: () =>
                      showDialog(context: context,
                          barrierDismissible: true,
                          builder: (BuildContext) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(onPressed: () => Navigator.pop(context) , child: Text("OK"))
                              ],
                              title: Text(AppLocalizations.of(context)!.moreInfoSchedule),
                              content: Text(
                                  "${AppLocalizations.of(context)!.schedule}: \n${event.horari!}\n"
                                      "${AppLocalizations.of(context)!.ticket}: \n${event.entrades!}\n"
                                      ),
                            );
                          }
                      ),
                ),
                _CustomIcon(
                  icon: Icons.map,
                  text: event.espai!,
                  onTap: () =>
                      showDialog(context: context,
                          barrierDismissible: true,
                          builder: (BuildContext) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(onPressed: () => Navigator.pop(context) , child: Text("OK")),
                                ElevatedButton(onPressed: () => {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SingleEventMap(event: event)))
                                }, child: Text(AppLocalizations.of(context)!.seeOnMap))
                              ],
                              title: Text(AppLocalizations.of(context)!.infoLocation),
                              content: Text(
                                  "${AppLocalizations.of(context)!.space}:\n${event.espai!}\n"
                                      "${AppLocalizations.of(context)!.address}:\n${event.adreca!}\n"
                                      "${AppLocalizations.of(context)!.location}:\n${event.ubicacio!}"),
                            );
                          }
                      ),
                ),
                if (Session().data.id != -1) _CustomIcon(
                  icon: Icons.chat_bubble,
                  text: AppLocalizations.of(context)!.chat,
                  onTap: () => {
                    Navigator.pushNamed(
                        context, "/xat",
                        arguments: EventUnicArgs(
                            event.id!))
                        .then((_) {})
                  },
                ),
                _CustomIcon(
                  icon: Icons.person,
                  text: event.nomOrganitzador!,
                  onTap: () =>
                      showDialog(context: context,
                          barrierDismissible: true,
                          builder: (BuildContext) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(onPressed: () => Navigator.pop(context) , child: Text(AppLocalizations.of(context)!.okButton)),
                                ElevatedButton(onPressed: () =>
                                {
                                  if (event.idOrganitzador != null)
                                    {
                                            Navigator.popAndPushNamed(
                                                    context, "/organizer",
                                                    arguments: OrganizerArgs(
                                                        event.idOrganitzador!, event.nomOrganitzador!))
                                                .then((_) {})
                                          }
                                      }, child: Text(AppLocalizations.of(context)!.seeMoreEventsByOrgButton))
                              ],
                              title: Text(AppLocalizations.of(context)!.orgInfoCardTitle, style: TextStyle(fontSize: 18),),
                              content: OrganizerCard(event)
                              // Text(
                              //     "Nom:\n${event.nomOrganitzador!}\n"
                              //         "Email:\n${event.emailOrganitzador!}\n"
                              //         "URL:\n${event.urlOrganitzador!}"),
                            );
                          }
                      ),
                ),
                // _CustomIcon(
                //   icon: Icons.av_timer_rounded,
                //   text: '50m',
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(child:Text(descripcio, textAlign: TextAlign.justify,style: const TextStyle(fontSize: 15, ),),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(AppLocalizations.of(context)!.tagsText, textAlign: TextAlign.justify,style: const TextStyle(fontSize: 15, ),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/12,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: event.getTags().length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: StadiumBorder(),
                          child: Card(
                            elevation: 0.0,
                            borderOnForeground: false,
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.pushNamed(context, '/tagEvents', arguments: TagArgs(event.getTags()[i]))
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(event.getTags()[i],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 15, ),
                                    )
                                  ]
                              )
                            ),
                          ),
                        )
                      );
                    }
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reviewsText,
                    style: TextStyle(fontSize: 23),
                  ),
                  IconButton(icon: Icon(Icons.edit), onPressed:() async {
                    final value = await Navigator.pushNamed(context, "/crearReview", arguments: CrearReviewArgs(viewModel.eventSelected.data!.id!));
                    setState(() {
                      viewModel.getReviews();
                    });
                  },
                  )
                ],
              ),
            ),
            !viewModel.isUser ?
                GestureDetector(
                  child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Center(
                          child: Material(
                            elevation: 20,
                            shadowColor: Colors.black.withAlpha(70),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Center(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppLocalizations.of(context)!.haventLoggedInYet, style:
                                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.grey), textAlign: TextAlign.center,),
                                  Text(AppLocalizations.of(context)!.clickHere, style:
                                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.red), textAlign: TextAlign.center,),
                                ],
                              )),
                            ),
                          ),
                        ),
                      )
                  ),
                  onTap: () => {
                    Navigator.pushNamed(context, "/login")
                  },
                )
            : viewModel.reviews.status == Status.LOADING?
            const SizedBox(
              child: Center(
                  child: CircularProgressIndicator()),
            ) :viewModel.reviews.status == Status.COMPLETED ?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: viewModel.reviews.data!.length>0? Column(
                  children: List<ReviewCard>.generate(viewModel.reviews.data!.length, (index) => ReviewCard(review: viewModel.reviews.data![index]))
              ): GestureDetector(
                onTap:() async {
                  final value = await Navigator.pushNamed(context, "/crearReview", arguments: CrearReviewArgs(viewModel.eventSelected.data!.id!));
                  setState(() {
                    viewModel.getReviews();
                  });
                  },
                child: Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Center(
                    child: Material(
                      elevation: 20,
                      shadowColor: Colors.black.withAlpha(70),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Center(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${AppLocalizations.of(context)!.noReviewsYet}\n${AppLocalizations.of(context)!.wantToLeaveAReview}", style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.grey), textAlign: TextAlign.center,),
                            Text(AppLocalizations.of(context)!.clickHere, style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.red), textAlign: TextAlign.center,),
                          ],
                        )),
                      ),
                    ),
                  ),
                )
              ),
            ) : Text(viewModel.reviews.message!),
            SizedBox(height: 50, width: 0,),

          ],
        ));
  }
}

class _CustomIcon extends StatelessWidget {
  const _CustomIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  String cutText(String t){
    String result = t;
    if(t.length > 20){
      result = "";
      for(int i = 0; i < t.length; ++i){
        result += t[i];
        if(i%20 == 0) result += "\n";
      }
    }
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 45,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width/4,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: const TextStyle( color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    )
    ;
  }
}

class _Features extends StatelessWidget {
  const _Features({
    Key? key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.colorline,
  }) : super(key: key);

  final Size size;
  final String title;
  final String subtitle;
  final Color colorline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: size.width,
      color: backgroundcolor,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    height: 5,
                    color: colorline,
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.pending,
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({
    Key? key,
    required this.size,
    required this.percent,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final double percent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * 0.015,
        left: 15,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: percent < .56
                ? Colors.white.withOpacity(1 - percent)
                : Colors.black,
          ),
        ));
  }
}

class CoverPhoto extends StatelessWidget {
  const CoverPhoto({
    Key? key,
    required this.size,
    required this.imgUrl,
  }) : super(key: key);

  final Size size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: size.width * 0.27,
      height: size.height * 0.18,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomBottomDescription extends StatelessWidget {
  const CustomBottomDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ],
    );
  }
}

class CutRectangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color(0xF4C20606);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.27, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DataCutRectangle extends StatelessWidget {
  const DataCutRectangle({
    Key? key,
    required this.size,
    required this.percent,
    required this.title,
  }) : super(key: key);

  final Size size;
  final double percent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.34, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: percent > 0.13
                    ? size.width * pow(percent, 5.5).clamp(0.0, 0.2)
                    : 0,
                top: size.height *
                    (percent > 0.48
                        ? pow(percent, 10.5).clamp(0.0, 0.06)
                        : 0.0)),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
              title,
              style: TextStyle( fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
            ),
          ),
          if (percent < 0.50) ...[
            const SizedBox(
              height: 2,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: (1 - pow(percent, 0.001)).toDouble(),
              child: const CustomBottomDescription(),
            )
          ]
        ],
      ),
    );
  }
}

