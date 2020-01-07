import 'dart:math';

import 'package:demo/config/router_manager.dart';
import 'package:demo/model/site.dart';
import 'package:demo/model/tree.dart';
import 'package:demo/ui/page/article/article_list_page.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/ui/widget/view_state_widget.dart';
import 'package:demo/view_model/article_model.dart';
import 'package:demo/view_model/square_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SquareState();
  }
}

class SquareState extends State<SquarePage> with AutomaticKeepAliveClientMixin {
  List<String> titles = ["广场", "体系", "导航"];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        initialIndex: 0,
        length: titles.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: TabBar(
                isScrollable: true,
                tabs: List.generate(
                    titles.length,
                    (index) => Tab(
                          text: titles[index],
                        ))),
          ),
          body: TabBarView(children: [
            ArticleListPage(SquareArticleModel()),
            SystemPage(),
            NaviSitePage()
          ]),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

///体系页面
class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemState();
  }
}

class SystemState extends State<SystemPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<SystemModel>(
        model: SystemModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return ViewStateLoadingWidget();
          } else if (model.isError) {
            return ViewStateErrorWidget(error:model.errorMessage,onPressed: model.initData);
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget();
          }
          return Scrollbar(
              child: ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    return SystemChildWidget(tree: model.list[index]);
                  }));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class SystemChildWidget extends StatelessWidget {
  final Tree tree;

  const SystemChildWidget({Key key, @required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tree.name,
              style: TextStyle(fontSize: 16),
            ),
            Wrap(
              children: List.generate(
                  tree.children.length,
                  (index) => Container(
                        margin: EdgeInsets.only(right: 12),
                        child: ActionChip(
                          elevation: 1,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey[200]
                                  : Colors.grey[500],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          label: Text(
                            tree.children[index].name,
                            style: TextStyle(
                                color: Colors.primaries[Random()
                                    .nextInt(Colors.primaries.length - 1)]),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RouteName.TREE,
                                arguments: {
                                  RouteArgumentKeys.KEY_TREE: tree,
                                  RouteArgumentKeys.KEY_TREE_INDEX: index
                                });
                          },
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

///导航
class NaviSitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NaviSiteState();
  }
}

class NaviSiteState extends State<NaviSitePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<NaviSiteModel>(
      model: NaviSiteModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isLoading) {
          return ViewStateLoadingWidget();
        } else if (model.isError) {
          return ViewStateErrorWidget(error:model.errorMessage,onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget();
        }
        return ListView.builder(itemBuilder: (context, index) {
          return NaviChildWidget(site: model.list[index]);
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NaviChildWidget extends StatelessWidget {
  final Site site;

  const NaviChildWidget({Key key, @required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              site.name,
              style: TextStyle(fontSize: 16),
            ),
            Wrap(
              children: List.generate(
                  site.articles.length,
                  (index) => Container(
                        margin: EdgeInsets.only(right: 12),
                        child: ActionChip(
                          elevation: 1,
                          backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey[200]
                              : Colors.grey[500],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          label: Text(
                            site.articles[index].title,
                            style: TextStyle(
                                color: Colors.primaries[Random()
                                    .nextInt(Colors.primaries.length - 1)]),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                RouteName.ARTICLE_DETAIL,
                                arguments: site.articles[index]);
                          },
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
