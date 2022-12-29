import 'package:flutter/material.dart';

import '../../constants/theme.dart';
import '../../models/ReviewResult.dart';

class ReviewUnica extends StatefulWidget {
  ReviewUnica({super.key, required this.review});
  ReviewResult review;

  @override
  State<ReviewUnica> createState() => _ReviewUnicaState();
}

class _ReviewUnicaState extends State<ReviewUnica> {

  late ReviewResult review = widget.review;

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(review.title!),
      // ),
      body: Center (
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                // flex: 2,
                child: Text(
                  review.author!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: MyColors.header,
                  ),
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
                        padding:  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child:
                       Row(
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
                        padding: const EdgeInsets.only(left: 10.0, top:8.0),
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
      )
    );
  }
}