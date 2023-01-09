import 'package:flutter/material.dart';

class SearchLocations extends SearchDelegate<String> {
  final List<String> allUsers;
  final List<String> allUsersSuggestion;

  SearchLocations({required this.allUsers, required this.allUsersSuggestion});

  @override
  List<Widget> buildActions(BuildContext context) {
    //botó per borrar String escrit i tornar a escriure
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //return a la llista
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        query = '';
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //llista dels resultats
    final List<String> usersList = allUsers
        .where(
          (user) => user.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(usersList[index]),
        onTap: () {
          query = usersList[index];
          close(context, query);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //lista de suggestions
    final List<String> usersSuggList = allUsersSuggestion
        .where(
          (userSugg) => userSugg.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: usersSuggList.length,
      itemBuilder: (contexy, index) => ListTile(
        title: Text(usersSuggList[index]),
        onTap: () {
          query = usersSuggList[index];
          close(context, query);
        },
      ),
    );
  }
}
