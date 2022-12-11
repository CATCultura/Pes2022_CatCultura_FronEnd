import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tryproject2/constants/theme.dart';
import 'package:provider/provider.dart';
import '../../data/response/apiResponse.dart';
import '../../viewModels/TagsViewModel.dart';

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
  final TagsViewModel viewModel = TagsViewModel();
  late List <String> tagsList = [];

  @override
  Widget build(BuildContext context) {
    viewModel.fetchTagsListApi();
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
                viewModel.tagsList.status == Status.LOADING? const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                ):
                viewModel.tagsList.status == Status.ERROR? Text(viewModel.tagsList.toString()):
                viewModel.tagsList.status == Status.COMPLETED? Column(
                  children: [
                    Expanded(
                      child: ListView.builder (
                          itemCount: viewModel
                              .tagsList
                              .data!
                              .length,
                          itemBuilder:
                              (BuildContext context,
                              int i) {
                            return EventInfoTile(
                              event: viewModel
                                  .tagsList
                                  .data![i],
                              index: i,
                            );
                          }),
                    ),
                  ],
                )
                    : const Text("asdfasdf"),
              ],
            ),
        ),
    );
  }
}