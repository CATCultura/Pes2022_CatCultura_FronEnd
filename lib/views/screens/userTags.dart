import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:CatCultura/viewModels/UsersViewModel.dart';
import 'package:provider/provider.dart';

import '../../data/response/apiResponse.dart';


class UserTags extends StatelessWidget {
  const UserTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulUserTags(),
    );
  }
}

class StatefulUserTags extends StatefulWidget {
  const StatefulUserTags({Key? key}) : super(key: key);

  @override
  State<StatefulUserTags> createState() => _StatefulUserTagsState();
}

class _StatefulUserTagsState extends State<StatefulUserTags> {
  bool? musica = false;
  //true for checked checkbox, flase for unchecked one

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
            padding: EdgeInsets.only(top:20, left:20, right:20),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Image.asset(
                          width: 70,
                          height: 70,
                          'resources/img/logo2.png',
                        )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(50),
                  child: const Text(
                    'Selecciona les teves categories favorites',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrangeAccent,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                CheckboxListTile( //checkbox positioned at right
                  value: musica,
                  onChanged: (bool? value) {
                    setState(() {
                      musica = value;
                    });
                  },
                  title: Text("Música"),
                ),
                CheckboxListTile( //checkbox positioned at right
                  value: musica,
                  onChanged: (bool? value) {
                    setState(() {
                      musica = value;
                    });
                  },
                  title: Text("Concerts"),
                ),
                CheckboxListTile( //checkbox positioned at right
                  value: musica,
                  onChanged: (bool? value) {
                    setState(() {
                      musica = value;
                    });
                  },
                  title: Text("Aire lliure"),
                ),
                CheckboxListTile( //checkbox positioned at right
                  value: musica,
                  onChanged: (bool? value) {
                    setState(() {
                      musica = value;
                    });
                  },
                  title: Text("Esports"),
                ),
                Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: OutlinedButton(
                          onPressed: () {
                            musica = false;
                          },
                          child: const Text("ESBORRA",
                            style: TextStyle (
                                fontSize: 12,
                                letterSpacing: 2.2,
                                color:Colors.black
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal:15),
                        child: ElevatedButton(
                          style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                          child: const Text('DESA',
                            style: TextStyle (
                                fontSize: 12,
                                letterSpacing: 2.2,
                                color:Colors.white
                            ),
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/home');
                          },
                        ),
                      ),
                    ]
                ),
                TextButton(
                  child: Center(
                    child: Text(
                      "Fes-ho més tard",
                      style:  TextStyle (
                          color:Colors.deepOrangeAccent
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/home');
                  },
                ),
              ],)
        )
    );
  }
}