import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';
import 'package:CatCultura/views/widgets/attributes.dart';


class crearEsdeveniments extends StatefulWidget {
  const crearEsdeveniments({super.key});

  @override
  State<crearEsdeveniments> createState() => _crearEsdevenimentsState();
}

class _crearEsdevenimentsState extends State<crearEsdeveniments> {
  String fecha = '';
  TextEditingController InitialDateController = TextEditingController();
  TextEditingController FinalDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Crear Esdeveniment"),
          backgroundColor: MyColorsPalette.orange,
        ),
        drawer: const MyDrawer("Crear Esdeveniment",username:"Superjuane", email:"juaneolivan@gmail.com"),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Center(
              child: Column(
                children: [
                  attributes("Codi"),
                  //createInitialDate(context),
                  createFinalDate(context),
                  attributes("Nom Esdeveniment"),
                  //attributes("Ubicació"),
                  //attributes("Categoria"),
                  Container(
                    height: 70,
                    width: 150,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColorsPalette.orange)),
                      child: const Text('Crear'),
                      onPressed: () {
                        //print(nameController.text);
                        //print(passwordController.text);
                        Navigator.popAndPushNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /**Widget createInitialDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextField(
          enableInteractiveSelection: false,
          controller: InitialDateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Data Inici",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange,
                  width: 3
              ),
            ),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            selectInitialDate(context);
          },
        ),
      ),
    );
  }**/

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

  /**selectInitialDate(BuildContext context) async{
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
        InitialDateController.text = fecha;
      });
    }
  }**/

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





