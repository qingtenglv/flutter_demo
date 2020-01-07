import 'package:demo/model/article.dart';
import 'package:demo/ui/page/article/article_detail_page.dart';
import 'package:demo/ui/page/article/tree_page.dart';
import 'package:demo/ui/page/me/collect_page.dart';
import 'package:demo/ui/page/me/login_page.dart';
import 'package:demo/ui/page/me/register_page.dart';
import 'package:demo/ui/page/splash_page.dart';
import 'package:demo/ui/page/me/coin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/ui/page/tab/tab_navigator.dart';

class RouteName {
  static const String SPLASH = "splash";
  static const String TAB_NAVIGATOR = "/";
  static const String ARTICLE_DETAIL = "article_detail";
  static const String LOGIN = "login";
  static const String REGISTER = "register";
  static const String COLLECT = "collect";
  static const String TREE = "tree";
  static const String COIN_RANK="coin_rank";
  static const String COIN_RECORD="coin_record";
}

class RouteArgumentKeys {
  static const String KEY_TREE = "key_tree";
  static const String KEY_TREE_INDEX = "key_tree_index";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SPLASH:
        return NoAnimationPageRoute(SplashPage());
      case RouteName.TAB_NAVIGATOR:
        return NoAnimationPageRoute(TabNavigator());
      case RouteName.ARTICLE_DETAIL:
        return CupertinoPageRoute(builder: (_) {
          var article = settings.arguments as Article;
          return ArticleDetailPage(
            article: article,
          );
        });
      case RouteName.LOGIN:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.REGISTER:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteName.TREE:
        return CupertinoPageRoute(builder: (_) {
          Map<String, dynamic> map = settings.arguments;
          return TreePage(
              tree: map[RouteArgumentKeys.KEY_TREE],
              index: map[RouteArgumentKeys.KEY_TREE_INDEX]);
        });
      case RouteName.COLLECT:
        bool hasUser = settings.arguments;
        if (hasUser) {
          return CupertinoPageRoute(builder: (_) => CollectPage());
        }
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.COIN_RANK:
        bool hasUser = settings.arguments;
        if (hasUser) {
          return CupertinoPageRoute(builder: (_) => CoinRankPage());
        }
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.COIN_RECORD:
        return CupertinoPageRoute(builder: (_) => CoinRecordPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text(""),
                  ),
                ));
    }
  }
}

class NoAnimationPageRoute extends PageRouteBuilder {
  final Widget page;

  NoAnimationPageRoute(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, a, sa) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder: (c, a, sa, child) => child);
}
