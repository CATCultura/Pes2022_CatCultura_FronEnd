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
  final TagsViewModel viewModel = TagsViewModel();
  late List <String> tagsList = [];
  List checkedTags = [];

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
    tagsList = viewModel.tagsList.data!;
    return ChangeNotifierProvider<TagsViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<TagsViewModel>(builder: (context, value, _) {
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
                    viewModel.tagsList.status == Status.COMPLETED? Row(
                      children: <Widget> [
                        Expanded(
                          child: Container(
                            height: 500.0,
                            child: ListView.builder (
                                itemCount: tagsList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return   CheckboxListTile( //checkbox positioned at right
                                    value: checkedTags.contains(tagsList[i]),
                                    onChanged: (bool? value) {
                                        _onSelected(value!, tagsList[i]);
                                    },
                                    title: Text(tagsList[i]),
                                    activeColor: Colors.deepOrangeAccent,
                                  );
                                }),
                          )
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

