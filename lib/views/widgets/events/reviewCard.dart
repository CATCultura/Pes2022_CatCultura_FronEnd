import 'package:CatCultura/models/ReviewResult.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:CatCultura/constants/theme.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewResult review;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: defaultFunc,
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
                        "User Name",
                        style: TextStyle(
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
                              Icon(/*review.score!*/ 3 > 0
                                  ? Icons.star
                                  : Icons.star_outline),
                              Icon(/*review.score!*/ 3 > 1
                                  ? Icons.star
                                  : Icons.star_outline),
                              Icon(/*review.score!*/ 3 > 2
                                  ? Icons.star
                                  : Icons.star_outline),
                              Icon(/*review.score!*/ 3 > 3
                                  ? Icons.star
                                  : Icons.star_outline),
                              Icon(/*review.score!*/ 3 > 4
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
                            child: Text("Title Review",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          // Padding(padding: EdgeInsets.only(top: 5)),
                          Flexible(
                              child: Text(
                                // "holsssssssssssssssssssssssssssssssssssssssssssssssssssa",
                                "Lorep ipsum xxxxxxxxxdddddddddddffffffffffffffffffffffffttttttttttttttttttttttttttttttttttttttttttddddddddddddddddddddddddddddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxssssssssssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxssssssssssssssssssssssss",
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
