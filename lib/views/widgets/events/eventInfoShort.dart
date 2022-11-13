
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../models/EventResult.dart';
import '../../../utils/functions/overflowFunctions.dart';

class EventInfoShort extends StatelessWidget {
  const EventInfoShort({
    Key? key,
    required this.event,
  }) : super(key: key);

  final EventResult event;

  @override
  Widget build(BuildContext context) {
    debugPrint("https://agenda.cultura.gencat.cat"+event.imatges![0]);
    return Column(
      //DOS PARTES
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //PARTE 1
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: [
              //DATA-ESPAI-COMARCA
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0, ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: MyColorsPalette.red,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 16)),
                          getSizedText("${event.dataInici} \n${event.dataFi}"),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: MyColorsPalette.red,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 16)),
                          getSizedText(event.denominacio!),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Row(
                        children: [
                          const Icon(
                            Icons.earbuds_rounded,
                            color: MyColorsPalette.red,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 16)),
                          getSizedText(event.comarcaIMunicipi!),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left:10,),),
              //IMATGE
              Expanded(
                flex: 3,
                child: SizedBox(
                  //height: 1,
                    child: Image.network("https://agenda.cultura.gencat.cat"+event.imatges![0])),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
