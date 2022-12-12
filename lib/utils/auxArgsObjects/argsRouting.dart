import 'package:CatCultura/models/ReviewResult.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';

class EventUnicArgs {
  final String eventId;
  EventUnicArgs(this.eventId);
}

class ReviewUnicaArgs {
  final ReviewResult review;
  ReviewUnicaArgs(this.review);
}

class CrearReviewArgs {
  final String eventId;
  CrearReviewArgs(this.eventId);
}

class AnotherProfileArgs{
  final String selectedUser;
  final String selectedId;
  AnotherProfileArgs(this.selectedUser, this.selectedId);
}