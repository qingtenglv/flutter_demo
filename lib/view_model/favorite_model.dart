
import 'package:demo/model/article.dart';
import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class FavoriteModel extends ViewStateModel{

  final FavoriteChangeModel model;

  FavoriteModel(this.model);

  collect(Article article) async {
    setLoading();
    try {
      if (article.collect == null) {
        await WanAndroidRepository.unMyCollect(
            id: article.id, originId: article.originId);
        model.removeFavorite(article.originId);
      } else {
        if (article.collect) {
          await WanAndroidRepository.unCollect(article.id);
          model.removeFavorite(article.id);
        } else {
          await WanAndroidRepository.collect(article.id);
          model.addFavorite(article.id);
        }
      }
      article.collect = !(article.collect ?? true);
      setIdle();
    } catch (e, s) {
      setError(e,s);
    }
  }

}

class FavoriteChangeModel extends ChangeNotifier{

  final Map<int,bool> _map=new Map();

  addFavorite(int id){
    _map[id]=true;
    notifyListeners();
  }

  removeFavorite(int id){
    _map[id]=false;
    notifyListeners();
  }

  /// 用于切换用户后,将该用户所有收藏的文章,对应的状态置为true
  replaceAll(List ids) {
    _map.clear();
    ids.forEach((id) => _map[id] = true);
    notifyListeners();
  }


  bool getFavorite(int id){
    return _map[id];
  }
}