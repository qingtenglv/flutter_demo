import 'package:demo/ui/page/article/article_list_page.dart';
import 'package:demo/view_model/article_model.dart';
import 'package:flutter/material.dart';

class CollectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: ArticleListPage(CollectArticleModel()),
    );
  }
}
