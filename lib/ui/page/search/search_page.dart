import 'package:demo/view_model/search_model.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {

  SearchHistoryModel _searchHistoryModel = SearchHistoryModel();
  SearchHotKeyModel _searchHotKeyModel = SearchHotKeyModel();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.isEmpty){
      return SizedBox.shrink();
    }else{
      return ResultWidget();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}


class ResultWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return null;
  }
}