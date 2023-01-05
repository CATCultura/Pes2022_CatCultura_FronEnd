import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:provider/provider.dart';
import '../../data/response/apiResponse.dart';
import '../../viewModels/TagsViewModel.dart';
import '../../utils/auxArgsObjects/argsRouting.dart';

class UserEditTags extends StatefulWidget {
  const UserEditTags({Key? key}) : super(key: key);

  @override
  State<UserEditTags> createState() => _UserEditTagsState();
}

class _UserEditTagsState extends State<UserEditTags> {
  final TagsViewModel viewModel = TagsViewModel();
  late List <String>? tagsList = [];
  List<String> checkedTags = [];
  List<String> unCheckedTags = [];

  void _onSelected(bool selected, String category) {
    if (selected == true) {
      setState(() {
        checkedTags.add(category);
        unCheckedTags.remove(category);
      });
    } else {
      setState(() {
        checkedTags.remove(category);
        unCheckedTags.add(category);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel.fetchTagsListApi();
    viewModel.fetchUserTags();
    return ChangeNotifierProvider<TagsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<TagsViewModel>(builder: (context, value, _) {
          return  Scaffold(
            body: Container(
              padding: EdgeInsets.only(top:40, left:20, right:20, bottom: 10),
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
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: const Text(
                        'EDITA ELS TAGS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.bold
                        ),
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
                                height: 450.0,
                                child: ListView.builder (
                                    itemCount: viewModel.tagsList.data?.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return SizedBox(
                                          width: 400,
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
                                                                value: checkedTags.contains(viewModel.tagsList.data![i]) ||
                                                                    viewModel.checkedTags.contains(viewModel.tagsList.data![i]),
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
                                                                  viewModel.tagsList.data![i],
                                                                  style: const TextStyle(
                                                                      color: Colors.black38,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                                activeColor: Colors.blueAccent
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
                        padding: const EdgeInsets.only(left: 0, top: 35, right: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Colors.redAccent)),
                                  child: const Text('CANCEL·LAR',
                                    style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 2.2,
                                        color: Colors.white
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(context, '/editProfile');
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Colors.blueAccent)),
                                  child: const Text('DESA',
                                    style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 2.2,
                                        color: Colors.white
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(context, '/userEditTags');
                                    if (checkedTags != []) viewModel.editUserTags(checkedTags);
                                    if (unCheckedTags != []) viewModel.deleteUserTags(unCheckedTags);
                                    viewModel.notifyListeners();
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
