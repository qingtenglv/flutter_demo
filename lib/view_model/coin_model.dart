import 'package:demo/model/coin.dart';
import 'package:demo/net/wan_android_repository.dart';
import 'package:demo/provider/view_state_list_refresh_model.dart';
import 'package:demo/provider/view_state_model.dart';

class CoinModel extends ViewStateModel {
  int count = 0;

  getCoinCount() async {
    setLoading();
    try{
      count = await WanAndroidRepository.fetchCoin();
      setIdle();
    }catch(e,s){
      setError(e, s);
    }
  }
}

class CoinRankModel extends ViewStateListRefreshModel{
  @override
  Future<List> loadData({int pageNum}) async{
    return await WanAndroidRepository.fetchRankingList(pageNum);
  }

}
class CoinRecordModel extends ViewStateListRefreshModel<Coin>{
  @override
  Future<List<Coin>> loadData({int pageNum}) async{
    return await WanAndroidRepository.fetchCoinRecordList(pageNum);
  }

}