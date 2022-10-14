import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';
import 'package:tryproject2/views/widgets/attributes.dart';



class crearEsdeveniments extends StatefulWidget {
  const crearEsdeveniments({super.key});

  @override
  State<crearEsdeveniments> createState() => _crearEsdevenimentsState();
}

class _crearEsdevenimentsState extends State<crearEsdeveniments> {
  String fecha = '';
  //TextEditingController nameController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();
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
        body: Center(
          child: Column(
            children: [
              attributes("Nom Esdeveniment"),
              _createInitialDate(context),
              _createFinalDate(context),
              attributes("Descripció"),
              attributes("Categoria"),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
    );
  }

  Widget _createInitialDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
        child: TextField(
          enableInteractiveSelection: false,
          controller: InitialDateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Data Inici",
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectInitialDate(context);
          },
        ),
      ),
    );
  }

  Widget _createFinalDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
        child: TextField(
          enableInteractiveSelection: false,
          controller: FinalDateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Data Fi",
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectFinalDate(context);
          },
        ),
      ),
    );
  }

  _selectInitialDate(BuildContext context) async{
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
  }

  _selectFinalDate(BuildContext context) async{
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





