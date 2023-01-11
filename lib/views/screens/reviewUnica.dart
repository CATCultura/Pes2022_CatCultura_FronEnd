import 'package:CatCultura/viewModels/ReviewNovaViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme.dart';
import '../../models/ReviewResult.dart';
import '../../viewModels/ReviewViewModel.dart';

class ReviewUnica extends StatefulWidget {
  ReviewUnica({super.key, required this.review});
  ReviewResult review;
  ReviewViewModel viewModel = ReviewViewModel();

  @override
  State<ReviewUnica> createState() => _ReviewUnicaState();
}

class _ReviewUnicaState extends State<ReviewUnica> {
  late ReviewViewModel viewModel = widget.viewModel;
  late ReviewResult review = widget.review;

  @override
  void initState() {
    super.initState();
    viewModel.setReview(review);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ReviewViewModel>(builder: (context, value, _) {
          return Scaffold(
              // appBar: AppBar(
              //   title: Text(review.title!),
              // ),
              body: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    // flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review.author!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: MyColors.header,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(review.upvotes.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: MyColors.header,
                                )),
                            IconButton(
                                onPressed: () {
                                  if(viewModel.isUpvoted) {
                                    viewModel.downvote();
                                    review.upvotes = review.upvotes! - 1;
                                  } else {
                                    viewModel.upvote();
                                    review.upvotes = review.upvotes! + 1;
                                  }
                                },
                                icon: viewModel.isUpvoted
                                    ? Icon(Icons.arrow_upward,
                                        color: Colors.blue, size: 30)
                                    : Icon(Icons.arrow_upward,
                                        color: Colors.black)),
                            // IconButton(
                            //   icon: AnimatedSwitcher(
                            //       duration:
                            //           const Duration(milliseconds: 350),
                            //       transitionBuilder: (child, anim) {
                            //         return RotationTransition(
                            //           turns:
                            //               child.key == ValueKey('icon1')
                            //                   ? Tween<double>(
                            //                           begin: 1,
                            //                           end: 0.75)
                            //                       .animate(anim)
                            //                   : Tween<double>(
                            //                           begin: 0.75,
                            //                           end: 1)
                            //                       .animate(anim),
                            //           child: ScaleTransition(
                            //               scale: anim, child: child),
                            //         );
                            //       },
                            //       child: viewModel.isUpvoted
                            //           ? Icon(Icons.arrow_upward,
                            //               color: Colors.blue,
                            //               size: 30,
                            //               key: const ValueKey('icon1'))
                            //           : Icon(
                            //               Icons.arrow_upward,
                            //               color: Colors.black,
                            //               key: const ValueKey('icon2'),
                            //             )),
                            //   onPressed: () {
                            //     setState(() {
                            //       viewModel.isUpvoted
                            //           ? viewModel.downvote()
                            //           : viewModel.upvote();
                            //     });
                            //   },
                            // ),
                            //IconButton(onPressed: (){debugPrint("buttonWorks!");}, icon: Icon(Icons.more_vert)),
                            PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'report') {
                                  viewModel.reportReview();
                                }
                                if (value == 'delete') {
                                  viewModel.deleteReview();
                                }
                              },
                              itemBuilder: (BuildContext bc) {
                                if (viewModel.isMine) {
                                  return const [
                                    PopupMenuItem(
                                      child: Text("Delete"),
                                      value: "delete",
                                    ),
                                  ];
                                } else {
                                  if (!viewModel.isReported) {
                                    return const [
                                      PopupMenuItem(
                                        child: Text("Report"),
                                        value: "report",
                                      ),
                                    ];
                                  } else {
                                    return const [];
                                  }
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    // flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9.0, bottom: 5.0),
                      child: SizedBox(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                children: [
                                  Icon(review.rating! > 0
                                      ? Icons.star
                                      : Icons.star_outline),
                                  Icon(review.rating! > 1
                                      ? Icons.star
                                      : Icons.star_outline),
                                  Icon(review.rating! > 2
                                      ? Icons.star
                                      : Icons.star_outline),
                                  Icon(review.rating! > 3
                                      ? Icons.star
                                      : Icons.star_outline),
                                  Icon(review.rating! > 4
                                      ? Icons.star
                                      : Icons.star_outline),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                  // Container(height: 80, child: HorizontalDivider(color: Colors.red)),
                  Divider(),
                  Flexible(
                    flex: 5,
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(review.title!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    // ),
                    // Padding(padding: EdgeInsets.only(top: 5)),
                    // ],
                    // ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        review.review!,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                        // overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }));
  }
}
