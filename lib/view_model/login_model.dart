import 'package:demo/config/storage_manager.dart';
import 'package:demo/model/user.dart';
import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_model.dart';
import 'package:demo/view_model/user_model.dart' ;

const String KEY_USER_NAME = "user_name";

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel);

  String getAccount() {
    return StorageManager.sharedPreferences.get(KEY_USER_NAME);
  }

  Future<bool> login({String account, String password}) async {
    setLoading();
    try {
      User user = await WanAndroidRepository.login(account, password);
      userModel.saveUser(user);
      StorageManager.sharedPreferences.setString(KEY_USER_NAME, user.username);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async{
    if(!userModel.hasUser){
      return false;
    }
    setLoading();
    try{
      await WanAndroidRepository.logout();
      userModel.clearUser();
      setIdle();
      return true;
    }catch(e,s){
      setError(e, s);
      return false;
    }
  }
}
