import 'package:demo/model/banner.dart';
import 'package:demo/model/coin.dart';
import 'package:demo/model/search.dart';
import 'package:demo/model/site.dart';
import 'package:demo/model/tree.dart';
import 'package:demo/model/article.dart';
import 'package:demo/model/user.dart';
import 'wan_android_api.dart';

class WanAndroidRepository {


  // 轮播
  static Future fetchBanners() async {
    var response = await api.get('banner/json');
    return response.data
        .map<Banner>((item) => Banner.fromJson(item))
        .toList();
  }

  // 置顶文章
  static Future fetchTopArticles() async {
    var response = await api.get('article/top/json');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }


  //项目分类
  static Future fetchProjectTreeCategories() async {
    var response = await api.get("project/tree/json");
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  //体系
  static Future fetchTreeCategories() async {
    var response = await api.get("tree/json");
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  // 导航
  static Future fetchNavigationSite() async {
    var response = await api.get('navi/json');
    return response.data.map<Site>((item) => Site.fromJson(item)).toList();
  }

  // 文章
  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await api.get('article/list/$pageNum/json',
        queryParameters: (cid != null ? {'cid': cid} : null));
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  //体系文章
  static Future fetchTreeArticles(int pageNum, int cid) async {
    var response = await api.get('article/list/$pageNum/json',
        queryParameters: (cid != null ? {"cid": cid} : null));
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  // 公众号分类
  static Future fetchGongzhonghaoCategories() async {
    var response = await api.get('wxarticle/chapters/json');
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  // 公众号文章
  static Future fetchGongzhonghaoArticles(int pageNum, int id) async {
    var response = await api.get('wxarticle/list/$id/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  // 广场文章
  static Future fetchSquareArticles(int pageNum) async {
    var response = await api.get('user_article/list/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  // 收藏文章
  static Future fetchCollectArticles(int pageNum) async {
    var response = await api.get('lg/collect/list/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  // 登录
  static Future login(String username, String password) async {
    var response = await api.post<Map>('user/login', queryParameters: {
      'username': username,
      'password': password,
    });
    return User.fromJson(response.data);
  }

  // 注册
  static Future register(
      String username, String password, String rePassword) async {
    var response = await api.post<Map>('user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJson(response.data);
  }

  // 登出
  static logout() async {
    await api.get('user/logout/json');
  }

  // 收藏
  static collect(id) async {
    await api.post('lg/collect/$id/json');
  }

  // 取消收藏
  static unCollect(id) async {
    await api.post('lg/uncollect_originId/$id/json');
  }

  // 取消收藏2
  static unMyCollect({id, originId}) async {
    await api.post('lg/uncollect/$id/json',
        queryParameters: {'originId': originId ?? -1});
  }

  // 个人积分
  static Future fetchCoin() async {
    var response = await api.get('lg/coin/getcount/json');
    return response.data;
  }

  // 我的积分记录
  static Future fetchCoinRecordList(int pageNum) async {
    var response = await api.get('lg/coin/list/$pageNum/json');
    return response.data['datas']
        .map<Coin>((item) => Coin.fromJson(item))
        .toList();
  }

  // 积分排行榜
  /// {
  ///        "coinCount": 448,
  ///        "username": "S**24n"
  ///      },
  static Future fetchRankingList(int pageNum) async {
    var response = await api.get('coin/rank/$pageNum/json');
    return response.data['datas'];
  }

  // 搜索热门记录
  static Future fetchSearchHotKey() async {
    var response = await api.get('hotkey/json');
    return response.data
        .map<SearchHotKey>((item) => SearchHotKey.fromMap(item))
        .toList();
  }

  // 搜索结果
  static Future fetchSearchResult({key = "", int pageNum = 0}) async {
    var response =
    await api.post<Map>('article/query/$pageNum/json', queryParameters: {
      'k': key,
    });
    return response.data['datas']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }
}
