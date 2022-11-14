import 'package:CatCultura/viewModels/EventsViewModel.dart';

class EventUnicArgs {
  final String eventId;

  EventUnicArgs(this.eventId);
}


class AnotherProfileArgs{
  final String selectedUser;
  final int selectedId;
  AnotherProfileArgs(this.selectedUser, this.selectedId);
}