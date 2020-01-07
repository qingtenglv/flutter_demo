import 'package:demo/model/site.dart';
import 'package:demo/model/tree.dart';
import 'package:demo/provider/view_state_list_model.dart';
import 'package:demo/net/wan_android_repository.dart';


//体系
class SystemModel extends ViewStateListModel<Tree>{

  @override
  Future<List<Tree>> loadData() async{
    return await WanAndroidRepository.fetchTreeCategories();
  }


}

//导航
class NaviSiteModel extends ViewStateListModel<Site>{

  @override
  Future<List<Site>> loadData() async{
    return await WanAndroidRepository.fetchNavigationSite();
  }

}