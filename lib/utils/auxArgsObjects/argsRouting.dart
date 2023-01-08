import 'package:CatCultura/models/EventResult.dart';
import 'package:CatCultura/models/ReviewResult.dart';
import 'package:CatCultura/viewModels/EventsViewModel.dart';

class EventUnicArgs {
  final String eventId;
  EventUnicArgs(this.eventId);
}

class OrganizerArgs {
  final int orgId;
  final String orgName;
  OrganizerArgs(this.orgId, this.orgName);
}

class TagArgs {
  final String tagName;
  TagArgs(this.tagName);
}

class QrCodeArgs {
  final String code;
  QrCodeArgs(this.code);
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

class EventArgs {
  final EventResult e;
  EventArgs(this.e);
}

class CrearUserArgs{
  final String name;
  final String user;
  final String email;
  final String password;
  CrearUserArgs(this.name, this.user, this.email, this.password);
}