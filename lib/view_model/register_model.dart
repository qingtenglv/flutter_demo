import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_model.dart';

class RegisterModel extends ViewStateModel {
  Future<bool> register({String account, String password, String rePassword}) async{
    setLoading();
    try{
      await WanAndroidRepository.register(account, password, rePassword);
      setIdle();
      return true;
    }catch(e,s){
      setError(e, s);
      return false;
    }
  }
}
