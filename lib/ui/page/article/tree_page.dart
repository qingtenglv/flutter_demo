import 'package:demo/model/tree.dart';
import 'package:demo/ui/page/article/article_list_page.dart';
import 'package:demo/view_model/article_model.dart';
import 'package:flutter/material.dart';

class TreePage extends StatefulWidget {
  final Tree tree;
  final int index;

  const TreePage({Key key, this.tree, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TreeState();
  }
}

class TreeState extends State<TreePage> with AutomaticKeepAliveClientMixin {
  Tree _tree;

  @override
  void initState() {
    super.initState();
    _tree = widget.tree;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      initialIndex: widget.index,
      length: _tree.children.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_tree.name),
          bottom: TabBar(
              isScrollable: true,
              tabs: List.generate(
                  _tree.children.length,
                  (index) => Tab(
                        text: _tree.children[index].name,
                      ))),
        ),
        body: TabBarView(
          children: List.generate(
              _tree.children.length,
              (index) =>
                  ArticleListPage(TreeArticleModel(_tree.children[index].id))),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
