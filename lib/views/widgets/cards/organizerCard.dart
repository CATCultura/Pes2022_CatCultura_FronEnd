import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../models/EventResult.dart';

class OrganizerCard extends StatelessWidget {
  final EventResult event;

  const OrganizerCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            event.nomOrganitzador!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: MyColors.header),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const Text("Email: "),
              Flexible(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                          event.emailOrganitzador == ""
                              ? "No email"
                              : event.emailOrganitzador!,
                          softWrap: false,
                          style:
                              const TextStyle(overflow: TextOverflow.fade)))),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const Text("URL: "),
              Flexible(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                          event.urlOrganitzador == ""
                              ? "No url"
                              : event.urlOrganitzador!,
                          softWrap: false,
                          style: const TextStyle(overflow: TextOverflow.fade))))
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const Text("Telèfon: "),
              Text(event.telefonOrganitzador == ""
                  ? "No telèfon"
                  : event.telefonOrganitzador!)
            ],
          )
        ],
      ),
    );
  }
}
