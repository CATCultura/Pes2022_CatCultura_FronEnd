import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:provider/provider.dart';
import '../../data/response/apiResponse.dart';
import '../../viewModels/TagsViewModel.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';
import '../../viewModels/LoginViewModel.dart';


class UserTags extends StatefulWidget {
  const UserTags({super.key, required this.name, required this.user, required this.email, required this.password});
  final String name;
  final String user;
  final String email;
  final String password;
  @override
  State<UserTags> createState() => _UserTagsState();
}

class _UserTagsState extends State<UserTags> {
  late String name = widget.name;
  late String user = widget.user;
  late String email = widget.email;
  late String password = widget.password;

  final TagsViewModel viewModel = TagsViewModel();
  final LoginViewModel viewModelLogin = LoginViewModel();

  List<String> checkedTags = [];

  void _onSelected(bool selected, String category) {
    if (selected == true) {
      setState(() {
        checkedTags.add(category);
      });
    } else {
      setState(() {
        checkedTags.remove(category);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel.fetchTagsListApi();
    return ChangeNotifierProvider<TagsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<TagsViewModel>(builder: (context, value, _) {
        return  Scaffold(
            body: Container(
                padding: EdgeInsets.only(top:20, left:20, right:20, bottom: 10),
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
                    viewModel.tagsList.status == Status.LOADING? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    ):
                    viewModel.tagsList.status == Status.ERROR? Text(viewModel.tagsList.toString()):
                    viewModel.tagsList.status == Status.COMPLETED? Column(
                      children: <Widget> [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 400.0,
                                child: ListView.builder (
                                    itemCount: viewModel.tagsList.data?.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return SizedBox(
                                        width: 400,
                                        //height: 90,
                                        child: Center(
                                          child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Column(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(1.0, 1.0), //Offset
                                                      blurRadius: 3.0,
                                                      spreadRadius: 1.0,
                                                    ), //BoxShadow
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      spreadRadius: 0.0,
                                                    ), //BoxShadow
                                                  ],
                                                ), //BoxDecorationDecoration

                                              child: CheckboxListTile( //checkbox positioned at right
                                                value: checkedTags.contains(viewModel.tagsList.data![i]),
                                                onChanged: (bool? selected) {
                                                  bool s = false;
                                                  if (selected != null) {
                                                    _onSelected(selected, viewModel.tagsList.data![i]);
                                                  }
                                                  else {
                                                    _onSelected(s, viewModel.tagsList.data![i]);
                                                  }
                                                },
                                                title: Text(
                                                  viewModel.tagsList.data![i].replaceAll('-', ' '),
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                activeColor: Colors.deepOrangeAccent
                                              )
                                            )
                                          ]
                                        )
                                      )
                                    )
                                  );
                                }),
                              )
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:16, top: 30, right:16),
                          child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, '/login');
                                      viewModelLogin.crearcompte(name, user, email, password, checkedTags);
                                      viewModelLogin.notifyListeners();
                                    },
                                    child: const Text("ARA NO",
                                      style: TextStyle (
                                          fontSize: 15,
                                          letterSpacing: 2.2,
                                          color:Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),
                                    child: const Text('DESA',
                                      style: TextStyle (
                                          fontSize: 15,
                                          letterSpacing: 2.2,
                                          color:Colors.white
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, '/login');
                                      viewModelLogin.crearcompte(name, user, email, password, checkedTags);
                                      viewModelLogin.notifyListeners();
                                      },
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    )

                        : const Text("Correct"),
                  ],
                ),
            ),
        );
    })
    );
  }
}


