import 'package:demo/view_model/favorite_model.dart';
import 'package:demo/view_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:demo/config/storage_manager.dart';
import 'package:demo/config/router_manager.dart';
import 'package:demo/view_model/theme_model.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider<ThemeModel>(builder: (context) => ThemeModel()),
  ChangeNotifierProvider<FavoriteChangeModel>(
      builder: (context) => FavoriteChangeModel()),
  ChangeNotifierProxyProvider<FavoriteChangeModel, UserModel>(
    builder: (context, favoriteChangeModel, userModel) =>
        userModel ?? UserModel(favoriteChangeModel),
  )
];

void main() async {
  Provider.debugCheckInvalidValueType = null;
  await StorageManager.init();
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
      providers: providers,
      child: Consumer<ThemeModel>(
          builder: (BuildContext context, ThemeModel themeModel, Widget child) {
        return MaterialApp(
          theme: themeModel.themeData(),
          darkTheme: themeModel.themeData(isDarkMode: true),
          onGenerateRoute: Router.generateRoute,
          initialRoute: RouteName.SPLASH,
        );
      }),
    ));
  }
}
