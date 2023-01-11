import 'package:CatCultura/models/ReviewResult.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:CatCultura/viewModels/ReviewNovaViewModel.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:provider/provider.dart';

import '../../../viewModels/ReviewViewModel.dart';
/*
 class UpvoteAnimation extends StatefulWidget {
  @override
  _UpvoteAnimationState createState() => _UpvoteAnimationState();
}

class _UpvoteAnimationState extends State<UpvoteAnimation> with SingleTickerProviderStateMixin {*/

class ReviewCard extends StatefulWidget {
  final ReviewViewModel viewModel = ReviewViewModel();
  final ReviewResult review;

  ReviewCard({super.key, required this.review});

  @override
  ReviewCardState createState() => ReviewCardState();
}

class ReviewCardState extends State<ReviewCard>
    with SingleTickerProviderStateMixin {
  late ReviewViewModel viewModel = widget.viewModel;
  late ReviewResult review = widget.review;
  late AnimationController _animationController;

  void defaultFunc() {
    print("the function works for review: ${review.title!}");
  }

  @override
  void initState() {
    super.initState();
    viewModel.setReview(review);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ReviewViewModel>(builder: (context, value, _) {
          return SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () async {
                  final value = await Navigator.pushNamed(context, "/reviewUnica",
                      arguments: ReviewUnicaArgs(review));
                  viewModel.reloadReview();
                },
                child: Card(
                  color: Color(0xFFf6f6f6),
                  elevation: 0.8,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review.author!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 9.0, bottom: 5.0),
                              child: SizedBox(
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
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(review.title!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                // Padding(padding: EdgeInsets.only(top: 5)),
                                Flexible(
                                  child: Text(
                                    review.review!,
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        }));
  }
}
