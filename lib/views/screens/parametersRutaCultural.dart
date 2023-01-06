import 'dart:ui';

import 'package:CatCultura/utils/auxArgsObjects/argsReturnParametersRutaCultural.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

double _currentSliderValue = 1000;

class ParametersRutaCultural extends StatefulWidget {
  const ParametersRutaCultural({super.key});

  @override
  ParametersRutaCulturalState createState() => ParametersRutaCulturalState();
}

class ParametersRutaCulturalState extends State<ParametersRutaCultural> {
  // double _currentSliderValue = 0;
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime(2022, 12,
          26))); //"2022-10-07T00:00:00.000" //DateFormat('dd-MM-yyyy').format(DateTime.now())
  /*TextField(
        controller: dateController, //editing controller of this TextField
          decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Date" //label text of field
            ),
           readOnly: true,  // when true user cannot edit text
           onTap: () async {
                  //when click we have to show the datepicker
            }
  )*/
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'resources/img/backgroundPhoto.jpg',
                    // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Text(
                                      'OPCIONS',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  componentText(Icons.calendar_today, 'Data',
                                      false, false, size, dateController),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                  ),
                                  componentSlider(Icons.question_mark, 'a',
                                      false, false, size),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                  ),
                                  // componentText(
                                  //   Icons.question_mark,
                                  //   'OPTION 2',
                                  //   true,
                                  //   false,
                                  //   size,
                                  //   ''
                                  // ),

                                  SizedBox(height: size.width * .1),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.pop(
                                          context,
                                          RutaCulturalArgs(
                                              1.0,
                                              2.0,
                                              _currentSliderValue.round(),
                                              privateDateFormat(
                                                  dateController.text)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'GENERAR RUTA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget componentText(IconData icon, String hintText, bool isPassword,
      bool isEmail, Size size, TextEditingController controller) {
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.white.withOpacity(.9),
          ),
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white.withOpacity(.8),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
          ),
          readOnly: true, // when true user cannot edit text
          onTap: () async {
            //when click we have to show the datepicker
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime
                    .now(), //DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));
            if (pickedDate != null) {
              //print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
              String formattedDate = DateFormat('dd-MM-yyyy').format(
                  pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
              //print(formattedDate); //formatted date output using intl package =>  2022-07-04
              //You can format date as per your need

              setState(() {
                controller.text =
                    formattedDate; //set foratted date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          }),
    );
  }



  //2022-10-07T00:00:00.000
  String privateDateFormat(String ogDate) {
    String day = ogDate[0] + ogDate[1];
    String month = ogDate[3] + ogDate[4];
    String year = ogDate[6] + ogDate[7] + ogDate[8] + ogDate[9];
    String result = "$year-$month-${day}T00:00:00.000";
    debugPrint(result);
    return result;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class componentSlider extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final Size size;

  componentSlider(this.icon, this.hintText, this.isPassword, this.isEmail,
      this.size);

  @override
  _componentSliderState createState() => _componentSliderState();
}

class _componentSliderState extends State<componentSlider> {


  late IconData icon;
  late String hintText;
  late bool isPassword;
  late bool isEmail;
  late Size size;

  @override
  void initState() {
    icon = widget.icon;
    hintText = widget.hintText;
    isPassword = widget.isPassword;
    isEmail = widget.isEmail;
    size = widget.size;
    super.initState();
  }

  final List<double> values = [
    1000,
    2000,
    3000,
    4000,
    5000,
    6000,
    7000,
    8000,
    9000,
    10000,
    11000,
    12000,
    13000,
    14000,
    15000,
    16000,
    17000,
    18000,
    19000,
    20000
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width / 3,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 15.0),
              child: Text(
                "SELECCIONA UN RADIO: ( ${_currentSliderValue.round()/1000} Km)",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(.5),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Slider(
              value: _currentSliderValue,
              min: 1000,
              max: 20000,
              divisions: 19,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            // Slider(
            //   value: values[selectedIndex],
            //   max: 300,
            //   divisions: 5,
            //   label: values[selectedIndex] == 300? "+∞" : values[selectedIndex].toString(),
            //   onChanged: (double value) {
            //     setState(() {
            //       selectedIndex = values.indexOf(value);
            //     });
            //   },
            // )
            // Slider(
            //   value: _currentSliderValue,
            //   max: 300,
            //   divisions: 5,
            //   label: _currentSliderValue == 300? "+∞" : _currentSliderValue.toString(),
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSliderValue = value;
            //     });
            //   },
            // )
            // Slider(
            //   value: 4,//2,//_currentSliderValue,
            //   min: 0,
            //   max: 513,
            //   divisions: 8,
            //   label: [0,4,8,16,24,32,128,512][_currentSliderValue.round()].toString(),
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSliderValue = value;
            //     });
            //   },
            // ),
            //label: _currentSliderValue == 15? "+∞" : _currentSliderValue.toString(),
          ),
        ],
      ),
    );
  }
}
