import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:tryproject2/constants/theme.dart';

class CardHorizontal extends StatelessWidget {
  const CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.backcolor = MyColors.lightBlue,
      this.img =
          "https://media.istockphoto.com/photos/arizona-state-fair-picture-id1008794422?k=20&m=1008794422&s=612x612&w=0&h=LBWbyxQnvWb5hSeLsi1-eFyoiKCTZqpj3Jb3YmtE2Hg=",
      this.onTap = defaultFunc});

  final String cta;
  final String img;
  final Color backcolor;
  final Function onTap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: GestureDetector(
          onTap: defaultFunc,
          child: Card(
            color: backcolor,
            elevation: 0.6,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  color: MyColors.header, fontSize: 13)),
                          TextButton(
                              onPressed: () => showModal(
                                configuration: const FadeScaleTransitionConfiguration(
                                  transitionDuration: Duration(milliseconds: 500),
                                ),
                                context: context,
                                builder: (ctx) => const AlertDialog(
                                  title: Text('BUTTON WORKS'),
                                  content: Text('The button Prueba works'),
                                ),
                              ),
                              child: Text(cta,
                                  style: const TextStyle(
                                      color: MyColors.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600)))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
