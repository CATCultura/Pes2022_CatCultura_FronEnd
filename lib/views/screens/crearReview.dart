import 'package:CatCultura/viewModels/ReviewNovaViewModel.dart';
import 'package:flutter/material.dart';

import '../../constants/theme.dart';
import '../../models/ReviewResult.dart';

class CrearReview extends StatefulWidget {
  CrearReview({super.key, required this.eventId});

  final String eventId;
  @override
  State<CrearReview> createState() => _CrearReviewState();
}

class _CrearReviewState extends State<CrearReview> {
  late String eventId = widget.eventId;
  final ReviewUnicaViewModel viewModel = ReviewUnicaViewModel();
  double rating = 1;

  TextEditingController titolController =
      TextEditingController(/*text: "admin"*/);
  TextEditingController revController =
      TextEditingController(/*text: "admin"*/);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review"),),
      // //APPBAR PERSONALIZADA OPCIONAL
      // PreferredSize(
      //     preferredSize: Size(double.infinity, 60),
      //     child: Container(
      //       alignment: Alignment.centerLeft,
      //       padding: EdgeInsets.only(left: 8.0),
      //       child: Row(
      //         children: [
      //           TextButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: Icon(Icons.arrow_back, color: Colors.black)),
      //           Text("Review")
      //         ],
      //       ),
      //       //decoration: BoxDecoration(color: Colors.green),
      //     )),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: TextField(
                controller: titolController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Títol",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: TextField(
                minLines: 2,
                maxLines: 10,
                controller: revController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Review",
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              decoration: BoxDecoration(
                //color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(25, 10, 15, 10),
              child: StarRating(
                rating: rating,
                onRatingChanged: (rating) => setState(() => this.rating = rating),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () async {
                        await viewModel.sendReview(eventId, titolController.text, revController.text, rating).then((_){
                          Navigator.pop(context);});
                        },
                      child: Text("Post")
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  late Color? color = Colors.yellow;

  StarRating({this.starCount = 5, this.rating = .0, required this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon =  Icon(
        size: 50.0,
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        size: 50.0,
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        size: 50.0,
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
  }
}