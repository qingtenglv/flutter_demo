import 'package:demo/config/storage_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  static const KEY_THEME_INDEX = "key_theme_index";
  static const KEY_DARK_MODE = "key_dark_mode";

  MaterialColor _themeColor;
  bool _isDarkMode;

  ThemeModel() {
    int index = StorageManager.sharedPreferences.get(KEY_THEME_INDEX) ?? 0;
    _themeColor = Colors.primaries[index];
    _isDarkMode = StorageManager.sharedPreferences.get(KEY_DARK_MODE) ?? false;
  }

  switchThemeMode({MaterialColor themeColor, bool isDarkMode}) {
    _themeColor = themeColor ?? _themeColor;
    _isDarkMode = isDarkMode ?? _isDarkMode;
    saveThemeColor2Storage();
    notifyListeners();
  }

  ThemeData themeData({bool isDarkMode: false}) {
    var isDark = isDarkMode || _isDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
        brightness: brightness,
        // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
        // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
        // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,);

    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),

      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(
        /// 解决中文hint不居中的问题 https://github.com/flutter/flutter/issues/40248
          subhead: themeData.textTheme.subhead
              .copyWith(textBaseline: TextBaseline.alphabetic)),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
//          textTheme: CupertinoTextThemeData(brightness: Brightness.light)
//      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }

  saveThemeColor2Storage() async {
    await StorageManager.sharedPreferences.setBool(KEY_DARK_MODE, _isDarkMode);
    await StorageManager.sharedPreferences
        .setInt(KEY_THEME_INDEX, Colors.primaries.indexOf(_themeColor));
  }
}
