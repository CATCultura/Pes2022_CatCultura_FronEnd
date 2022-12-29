import 'package:CatCultura/models/ReviewResult.dart';
import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:CatCultura/constants/theme.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewResult review;

  void defaultFunc() {
    print("the function works for review: ${review.title!}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/reviewUnica",arguments: ReviewUnicaArgs(review));
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
                      child: Text(
                        review.author!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MyColors.header,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9.0, bottom: 5.0),
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
                              Icon(review.rating!> 3
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
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
  }
}
