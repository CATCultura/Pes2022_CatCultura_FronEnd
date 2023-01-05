import 'package:flutter/cupertino.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Oopsies"),
          SizedBox(
            height: 400,
            child: SizedBox(

                child: Image.asset('resources/img/error.png', scale: 2.0,)
            ),
          ),

        ],
      ),
    );
  }

}