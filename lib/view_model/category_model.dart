import 'package:demo/model/tree.dart';
import 'package:demo/provider/view_state_list_model.dart';
import 'package:demo/net/wan_android_repository.dart';

class ProjectCategoryModel extends ViewStateListModel<Tree>{

  @override
  Future<List<Tree>> loadData() async{
    return await WanAndroidRepository.fetchProjectTreeCategories();
  }


}

class GongzhonghaoCategoryModel extends ViewStateListModel<Tree>{

  @override
  Future<List<Tree>> loadData() async{
    return await WanAndroidRepository.fetchGongzhonghaoCategories();
  }

}