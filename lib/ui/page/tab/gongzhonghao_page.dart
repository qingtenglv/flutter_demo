
import 'package:demo/ui/page/article/article_list_page.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/ui/widget/view_state_widget.dart';
import 'package:demo/view_model/article_model.dart';
import 'package:demo/view_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'project_page.dart';

class GongPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GongState();
  }
}

class GongState extends State<GongPage> with AutomaticKeepAliveClientMixin {
  TabController _controller;
  ValueNotifier<int> _valueNotifier;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<GongzhonghaoCategoryModel>(
        model: GongzhonghaoCategoryModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return ViewStateLoadingWidget();
          } else if (model.isError) {
            return ViewStateErrorWidget(error:model.errorMessage,onPressed: model.initData);
          }
          return ValueListenableProvider<int>.value(
              value: _valueNotifier,
              child: DefaultTabController(
                  length: model.list.length,
                  initialIndex: 0,
                  child: Builder(builder: (context) {
                    if (_controller == null) {
                      _controller = DefaultTabController.of(context);
                      _controller.addListener(() {
                        _valueNotifier.value = _controller.index;
                      });
                    }
                    return Scaffold(
                      appBar: AppBar(
                        title: Stack(
                          children: <Widget>[
                            CategoryDropdownWidget(
                                Provider.of<GongzhonghaoCategoryModel>(
                                    context)),
                            Container(
                              margin: EdgeInsets.only(right: 25),
                              color:
                                  Theme.of(context).primaryColor.withOpacity(1),
                              child: TabBar(
                                isScrollable: true,
                                tabs: List.generate(
                                    model.list.length,
                                    (index) => Tab(
                                          text: model.list[index].name,
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: List.generate(
                            model.list.length,
                            (index) => Center(
                                  child: ArticleListPage(GongArticleModel(model.list[index].id)),
                                )),
                      ),
                    );
                  })));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
