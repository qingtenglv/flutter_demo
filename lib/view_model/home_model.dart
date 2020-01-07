import 'package:demo/model/article.dart';
import 'package:demo/model/banner.dart';
import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_list_refresh_model.dart';

class HomeModel extends ViewStateListRefreshModel {
  List<Banner> _banners;
  List<Article> _tops;

  get banner => _banners;

  get top => _tops;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == 0) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if(pageNum==0){
      _banners = result[0];
      _tops = result[1];
      return result[2];
    }else{
      return result[0];
    }
  }
}
