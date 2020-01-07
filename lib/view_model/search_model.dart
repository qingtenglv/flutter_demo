

import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_list_model.dart';
import 'package:demo/provider/view_state_list_refresh_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kSearchHistory = 'kSearchHistory';
class SearchHotKeyModel extends ViewStateListModel{
  @override
  Future<List> loadData() async{
     return await WanAndroidRepository.fetchSearchHotKey();
  }

}

class SearchHistoryModel extends ViewStateListModel<String> {
  clearHistory() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(kSearchHistory);
    list.clear();
    setEmpty();
  }

  addHistory(String keyword) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var histories = sharedPreferences.getStringList(kSearchHistory) ?? [];
    histories
      ..remove(keyword)
      ..insert(0, keyword);
    await sharedPreferences.setStringList(kSearchHistory, histories);
    notifyListeners();
  }

  @override
  Future<List<String>> loadData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(kSearchHistory) ?? [];
  }
}

class SearchResultModel extends ViewStateListRefreshModel {
  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResultModel({this.keyword, this.searchHistoryModel});

  @override
  Future<List> loadData({int pageNum}) async {
    if (keyword.isEmpty) return [];
    searchHistoryModel.addHistory(keyword);
    return await WanAndroidRepository.fetchSearchResult(
        key: keyword, pageNum: pageNum);
  }
}
