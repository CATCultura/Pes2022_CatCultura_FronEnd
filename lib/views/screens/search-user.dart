import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryproject2/constants/theme.dart';

import '../widgets/search_locations.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatefulSearchUser(),
    );
  }
}


class StatefulSearchUser extends StatefulWidget {
  const StatefulSearchUser({Key? key}) : super(key: key);

  @override
  State<StatefulSearchUser> createState() => _StatefulSearchUserState();
}
class _StatefulSearchUserState extends State<StatefulSearchUser> {
  String selectedUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Cercar Usuaris",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          )
          //centerTitle: true,
      ),
        body: Column(
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.search), label: const Text("Search"),
                style: OutlinedButton.styleFrom(
                    primary: Colors.deepOrange,
                    side: const BorderSide(color: Colors.orange),
                ), onPressed: () async{
                    final finalResult = await showSearch(
                        context: context,
                        delegate: SearchLocations(
                            allUsers: usersList,
                            allUsersSuggestion: usersList,
                        ),
                    );
                    setState((){
                        selectedUser = finalResult!;
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.popAndPushNamed(context, '/another-user-profile');

                  },
             // onPressed: (){},
            ),

          ]
        )
    );

  }
}

final List <String> usersList = [
  'Alejandro',
  'Manolo',
  'Pepe',
  'Joanna',
  'Adiosbuenosdias',


];

/*
class _StatefulSearchUserState extends State<StatefulSearchUser>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text("Buscar"),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],
        ),
        body: Center(

          child: FutureBuilder(

            future:
            DefaultAssetBundle.of(context).loadString("files/details.json"),
            builder: (context, snapshot) {
              // Decode the JSON
              var newData = json.decode(snapshot.data.toString());

              return ListView.builder(

                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    shadowColor: Colors.orange,
                    elevation: 49,
                    margin: EdgeInsets.only(top: 25),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  /*
                             * Navigator.push(
                                //context
                                //MaterialPageRoute(
                                //builder: (_) => LoginPage())
                                );
                             */
                                },
                                child: Text(

                                  newData[index]["id"],
                                  //"Note Title",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black26,
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                          //SizedBox(width: 20),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: newData == null ? 0 : newData.length,
              );
            },
          ),
        ));
  }
}
*/
/*
Widget getAppBarNotSearching(String title, Function startSearchFunction) {
  return AppBar(
    title: Text(title),
    actions: <Widget>[
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            startSearchFunction();
          }),
    ],
  );
}

 */
/*void startSearching() {
    setState(() {
      _isSearching = true;
    });
  }
*/
/*
  Widget getAppBarSearching(Function cancelSearch, Function searching,
      TextEditingController searchController) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            cancelSearch();
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: searchController,
          onEditingComplete: () {
            searching();
          },
          style: new TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: const InputDecoration(
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }

 */
//}

/*

class _MySearchDelegate extends SearchDelegate<String> {
    final List<String> _words;
    final List<String> _history;

    _MySearchDelegate(List<String> words)
        : _words = words,
          _history = <String>['apple', 'hello', 'world', 'flutter'],
          super();

    // Leading icon in search bar.
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        tooltip: 'Back',
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
          this.close(context, '');
        },
      );
    }

    // Widget of result page.
    @override
    Widget buildResults(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('You have selected the word:'),
              GestureDetector(
                onTap: () {
                  // Returns this.query as result to previous screen, c.f.
                  // `showSearch()` above.
                  this.close(context, this.query);
                },
                child: Text(
                  this.query,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Suggestions list while typing (this.query).
    /*
    @override
    Widget buildSuggestions(BuildContext context) {
      final Iterable<String> suggestions = this.query.isEmpty
          ? _history
          : _words.where((word) => word.startsWith(query));

      return _SuggestionList(
        query: this.query,
        suggestions: suggestions.toList(),
        onSelected: (String suggestion) {
          this.query = suggestion;
          this._history.insert(0, suggestion);
          showResults(context);
        },
      );
    }
    */


    // Action buttons at the right of search bar.
    @override
    List<Widget> buildActions(BuildContext context) {
      return <Widget>[
        if (query.isEmpty)
          IconButton(
            tooltip: 'Voice Search',
            icon: const Icon(Icons.mic),
            onPressed: () {
              this.query = 'TODO: implement voice input';
            },
          )
        else
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
              showSuggestions(context);
            },
          )
      ];
    }
  }

*/