import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/theme.dart';
import '../widgets/attributes.dart';

class modificarEsdeveniment extends StatefulWidget {
  const modificarEsdeveniment({super.key});

  @override
  State<modificarEsdeveniment> createState() => _modificarState();
}

class _modificarState extends State<modificarEsdeveniment> {
  String fecha = '';
  TextEditingController FinalDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar Esdeveniment'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            attributes("Nom Esdeveniment"),
            createFinalDate(context),
            Container(
              height: 70,
              width: 150,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.blue)),
                child: const Text('Modificar'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createFinalDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextField(
          enableInteractiveSelection: false,
          controller: FinalDateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Data Fi",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange,
                  width: 3
              ),
            ),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            selectFinalDate(context);
          },
        ),
      ),
    );
  }

  selectFinalDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2999),
    );
    if (picked != null) {
      var date = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        fecha = date;
        FinalDateController.text = fecha;
      });
    }
  }
}
