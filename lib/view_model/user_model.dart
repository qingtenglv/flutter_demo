import 'package:demo/config/storage_manager.dart';
import 'package:demo/model/user.dart';
import 'package:demo/view_model/favorite_model.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  static const String KEY_USER = "user";

  User _user;
  FavoriteChangeModel _model;

  get user => _user;

  bool get hasUser => user != null;

  UserModel(FavoriteChangeModel model) {
    var userMap = StorageManager.localStorage.getItem(KEY_USER);
    _model=model;
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    _model.replaceAll(_user.collectIds);
    StorageManager.localStorage.setItem(KEY_USER, _user);
    notifyListeners();
  }

  clearUser() {
    _user = null;
    notifyListeners();
  }
}
