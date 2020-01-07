import 'package:demo/model/article.dart';
import 'package:demo/provider/view_state_list_refresh_model.dart';
import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/view_model/favorite_model.dart';



class ProjectArticleModel extends ViewStateListRefreshModel<Article> {
  final int cid;

  ProjectArticleModel(this.cid);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: cid);
  }

}

class GongArticleModel extends ViewStateListRefreshModel<Article> {
  final int id;

  GongArticleModel(this.id);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchGongzhonghaoArticles(pageNum, id);
  }

}

class SquareArticleModel extends ViewStateListRefreshModel<Article> {
  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchSquareArticles(pageNum);
  }
}

class CollectArticleModel extends ViewStateListRefreshModel<Article> {
  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchCollectArticles(pageNum);
  }

}

class TreeArticleModel extends ViewStateListRefreshModel<Article> {

  final int cid ;

  TreeArticleModel(this.cid);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchTreeArticles(pageNum, cid);
  }

}
