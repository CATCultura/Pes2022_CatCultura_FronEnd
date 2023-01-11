import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.somethingWentWrong),
        SizedBox(
          height: 400,
          child: SizedBox(
              child: Image.asset('resources/img/error.png', scale: 2.0,)
          ),
        ),

      ],
    );
  }

}