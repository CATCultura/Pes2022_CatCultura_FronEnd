import 'dart:math';
import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:flutter/material.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:CatCultura/views/widgets/events/reviewCard.dart';
import 'dart:math' as math;

import '../../constants/theme.dart';
import '../../data/response/apiResponse.dart';
import '../../models/ReviewResult.dart';

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
    viewModel.selectEventById(eventId);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
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
                  child: Body(size: size,
                      date: viewModel.eventSelected.data!.dataInici!+"\n"+viewModel.eventSelected.data!.dataFi!,
                      place: viewModel.eventSelected.data!.espai! +" -\n"+viewModel.eventSelected.data!.comarcaIMunicipi!,
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

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.size,
    required this.date,
    required this.place,
    required this.descripcio,
    required this.viewModel,
  }) : super(key: key);

  final Size size;
  final String date;
  final String place;
  final String descripcio;
  final EventUnicViewModel viewModel;
  final String loggedUserId = "2";

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        color: backgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
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
            IconButton(
              iconSize: 40,
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.popAndPushNamed(
                    context, '/opcions-Esdeveniment',
                    arguments: EventArgs(viewModel.eventSelected.data!));
                },
            ),

            IconButton(
              // padding: const EdgeInsets.only(bottom: 5.0),
              iconSize: 40,
              icon: Icon((viewModel.agenda == false) ? Icons.flag_outlined : Icons.flag, color: Color(0xF4C20606)),
              onPressed: (){
                if(viewModel.agenda == true) {
                  viewModel.deleteAttendanceById(loggedUserId, viewModel.eventSelected.data!.id);
                  //widget.callback!("deleteAttendance");
                  //NotificationService().deleteOneNotification(event!.id);
                }
                else {
                  viewModel.putAttendanceById(loggedUserId, viewModel.eventSelected.data!.id);
                  // widget.callback!("addAttendance");
                  // NotificationService().showNotifications( event!.id, 8, "title", "body"); //widget.callback!("addAttendance");
                }
              },
            ),
            IconButton(
              // padding: const EdgeInsets.only(bottom: 5.0),
              iconSize: 40,
              icon: Icon((viewModel.favorit == false) ? Icons.star_border_outlined : Icons.star,color: Color(0xF4C20606)),
              onPressed: (){
                if(viewModel.favorit == true){
                  viewModel.deleteFavouriteById(loggedUserId, viewModel.eventSelected.data!.id);
                  // widget.callback!("deleteFavourite");
                }
                else{
                  viewModel.putFavouriteById(loggedUserId, viewModel.eventSelected.data!.id);
                  // widget.callback!("addFavourite");
                }
              },
            ),
          ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                _CustomIcon(
                  icon: Icons.calendar_month,
                  text: date,
                ),
                _CustomIcon(
                  icon: Icons.map,
                  text: place,
                ),
                // _CustomIcon(
                //   icon: Icons.wc,
                //   text: 'Tv +14',
                // ),
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
              padding: EdgeInsets.only(left: 15.0, bottom: 10, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 23),
                  ),
                  IconButton(icon: Icon(Icons.edit), onPressed: () {
                    // print("Button works");
                    Navigator.pushNamed(context, "/crearReview", arguments: CrearReviewArgs(viewModel.eventSelected.data!.id!));
                    },
                  )
                ],
              ),
            ),
            viewModel.reviews.status == Status.LOADING?
            const SizedBox(
              child: Center(
                  child: CircularProgressIndicator()),
            ) :viewModel.reviews.status == Status.COMPLETED ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(

                  children: List<ReviewCard>.generate(5, (index) => ReviewCard(review: viewModel.reviews.data![index]))
                  // children: List.generate(
                  //     5,
                  //         (index) => Padding(
                  //       padding: const EdgeInsets.only(left: 8.0),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: ReviewCard(review: viewModel.reviews.data![index]),
                  //       ),
                  //     )
                  // )
              ),
            ) : Text(viewModel.reviews.message!),


          ],
        ));
  }
}

class _CustomIcon extends StatelessWidget {
  const _CustomIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

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
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 45,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/2 -5,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: const TextStyle( color: Colors.grey),
            ),
          ),
        )
      ],
    );
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
          fit: BoxFit.fill,
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
        // Text(
        //   'Drama 😱 Fantasy 👨‍🚒 Science Fiction ✈️',
        //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        // ),
        // SizedBox(
        //   height: 2,
        // ),
        // Text(
        //   'Mistery 🕵️ Adventure 🚣',
        //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        // )
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

// import 'package:CatCultura/utils/functions/overflowFunctions.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'package:CatCultura/constants/theme.dart';
// import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
// import 'package:CatCultura/views/widgets/myDrawer.dart';
// import '../../../utils/functions/overflowFunctions.dart';
//
// import '../../data/response/apiResponse.dart';
// import '../../utils/auxArgsObjects/argsRouting.dart';
// import '../widgets/events/eventInfoShort.dart';
// import '../widgets/events/eventInfoTabs.dart';
//
// class EventUnic extends StatefulWidget {
//   EventUnic({super.key, required this.eventId});
//   String eventId;
//   EventUnicViewModel viewModel = EventUnicViewModel();
//
//   @override
//   State<EventUnic> createState() => _EventUnicState();
// }
//
// class _EventUnicState extends State<EventUnic> {
//   late String eventId = widget.eventId;
//   late EventUnicViewModel viewModel = widget.viewModel;
//
//   @override
//   void initState() {
//     viewModel.selectEventById(eventId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<EventUnicViewModel>(
//         create: (BuildContext context) => viewModel,
//         child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
//           return Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Container(
//                       height: MediaQuery.of(context).size.height * .65,
//                       color: Colors.blue,
//                       child: viewModel.eventSelected.status == Status.LOADING? SizedBox(
//                         height: MediaQuery.of(context).size.height,
//                         child: const Center(child: CircularProgressIndicator()),
//                       ):
//                       Image.network("https://agenda.cultura.gencat.cat" +
//                           viewModel.eventSelected.data!.imgApp!)),
//                   Container(
//                     height: MediaQuery.of(context).size.height * .35,
//                     color: Colors.white,
//                   )
//                 ],
//               ),
//               Container(
//                 alignment: Alignment.topCenter,
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * .58),
//                 child: Expanded(
//                   child: Container(
//                     height: 200.0,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent,
//                     child: CustomScrollView(
//                       slivers: <Widget>[
//                         const SliverAppBar(
//                           pinned: true,
//                           expandedHeight: 250.0,
//                           flexibleSpace: FlexibleSpaceBar(
//                             title: Text('Demo'),
//                           ),
//                         ),
//                         SliverGrid(
//                           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                             maxCrossAxisExtent: 200.0,
//                             mainAxisSpacing: 10.0,
//                             crossAxisSpacing: 10.0,
//                             childAspectRatio: 4.0,
//                           ),
//                           delegate: SliverChildBuilderDelegate(
//                                 (BuildContext context, int index) {
//                               return Container(
//                                 alignment: Alignment.center,
//                                 color: Colors.teal[100 * (index % 9)],
//                                 child: Text('Grid Item $index'),
//                               );
//                             },
//                             childCount: 20,
//                           ),
//                         ),
//                         SliverFixedExtentList(
//                           itemExtent: 50.0,
//                           delegate: SliverChildBuilderDelegate(
//                                 (BuildContext context, int index) {
//                               return Container(
//                                 alignment: Alignment.center,
//                                 color: Colors.lightBlue[100 * (index % 9)],
//                                 child: Text('List Item $index'),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Card(
//                     //   color: Colors.white,
//                     //   elevation: 4.0,
//                     // ),
//                   ),
//                 ),
//               )
//             ],
//           );
//         }));
//   }
// }
//
// // class EventUnic extends StatelessWidget {
// //   EventUnic({super.key, required this.eventId});
// //   EventUnicViewModel viewModel = EventUnicViewModel(); // = EventsViewModel();
// //   String eventId;
// //
// //   @override
// //   void initState() {
// //     // debugPrint("initializing state of EventUnic");
// //     // viewModel.selectEventById(eventId);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     debugPrint("building EventUnic with ID: $eventId");
// //     viewModel.selectEventById(eventId);
// //     return ChangeNotifierProvider<EventUnicViewModel>(
// //         create: (BuildContext context) => viewModel,
// //         child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
// //           return Scaffold(
// //               appBar: AppBar(
// //                 title: viewModel.eventSelected.status == Status.LOADING
// //                     ? Text("...")
// //                     : Center(
// //                         child: FittedBox(
// //                           fit: BoxFit.contain,
// //                           child: //Text(
// //                               getSizedText(
// //                                   viewModel.eventSelected.data!.denominacio!),
// //                           // overflow: TextOverflow.clip,
// //                           //   style: const TextStyle(color: MyColorsPalette.white,
// //                           //     fontWeight: FontWeight.bold, ),
// //                           // ),
// //                         ),
// //                       ),
// //                 backgroundColor: Color(0xFF3F3F44),
// //                 actions: <Widget>[
// //                   IconButton(
// //                       onPressed: () {
// //                         print(eventId);
// //                         Navigator.popAndPushNamed(
// //                             context, '/opcions-Esdeveniment',
// //                             arguments: EventUnicArgs(eventId));
// //                       },
// //                       icon: Icon(Icons.settings)),
// //                 ],
// //               ),
// //               //drawer: MyDrawer(""),
// //               body: Container(
// //                 //padding: const EdgeInsets.only(top:10.0),
// //                 child: viewModel.eventSelected.status == Status.LOADING
// //                     ? SizedBox(
// //                         height: MediaQuery.of(context).size.height,
// //                         child: const Center(child: CircularProgressIndicator()),
// //                       )
// //                     : viewModel.eventSelected.status == Status.ERROR
// //                         ? Text(viewModel.eventSelected.toString())
// //                         : viewModel.eventSelected.status == Status.COMPLETED
// //                             ? Column(
// //                                 children: [
// //                                   Expanded(
// //                                     flex: 2,
// //                                     //padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 1.0),
// //                                     child: Row(
// //                                       children: [
// //                                         //DATA-ESPAI-COMARCA
// //                                         Expanded(
// //                                           child: FittedBox(
// //                                               fit: BoxFit.fill,
// //                                               //   child: Image.network("https://agenda.cultura.gencat.cat"+event.imatges![0])),
// //                                               child: Image.network(
// //                                                   "https://agenda.cultura.gencat.cat" +
// //                                                       viewModel.eventSelected
// //                                                           .data!.imgApp!)),
// //
// //                                           // //flex: 4,
// //                                           // child:
// //                                           // EventInfoShort(event: viewModel.eventSelected.data!),
// //                                         ),
// //                                         //const Padding(padding: EdgeInsets.only(left: 10.0)),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   //const Padding(padding: EdgeInsets.only(top: 100.0)),
// //                                   Expanded(
// //                                     flex: 3,
// //                                     child: Container(
// //                                         decoration: const BoxDecoration(
// //                                             // border: Border(
// //                                             //   top: BorderSide(
// //                                             //     color: Colors.grey,
// //                                             //     style: BorderStyle.solid,
// //                                             //     width: 3,
// //                                             //   ),
// //                                             // ),
// //                                             ),
// //                                         //padding: const EdgeInsets.only(top:25.0),
// //                                         //margin: const EdgeInsets.only(top: 50),
// //                                         child: Column(
// //                                           crossAxisAlignment:
// //                                               CrossAxisAlignment.start,
// //                                           children: [
// //                                             Expanded(
// //                                                 child: EventInfoTabs(
// //                                                     event: viewModel
// //                                                         .eventSelected.data!)),
// //                                           ],
// //                                         )),
// //                                   ),
// //                                 ],
// //                               )
// //                             : const Text("asdfasdf"),
// //
// //                 //EventContainer(eventId: eventId),
// //               ));
// //         }));
// //   }
// // }
@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.more_horiz),
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.red,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,

      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}