import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;
  static LocalStorage localStorage;
  static Directory temporaryDirectory;

  static init() async {
    temporaryDirectory= await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('local');
    await localStorage.ready;
  }
}
