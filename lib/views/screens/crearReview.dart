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

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hola Review Nova"),),
    );
  }
}