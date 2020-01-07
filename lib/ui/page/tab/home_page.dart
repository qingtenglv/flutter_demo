import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/config/resource_mananger.dart';
import 'package:demo/config/router_manager.dart';
import 'package:demo/model/article.dart';
import 'package:demo/ui/page/article/article_list_page.dart';
import 'package:demo/ui/page/search/search_page.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/ui/widget/skeleton_widget.dart';
import 'package:demo/ui/widget/view_state_widget.dart';
import 'package:demo/view_model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  ScrollController _controller = new ScrollController();

  ValueNotifier<bool> _showTitle = ValueNotifier(false);
  double _bannerHeight;

  bool _showButton = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > _bannerHeight - kToolbarHeight &&
          !_showTitle.value) {
        _showTitle.value = true;
        setState(() {
          _showButton = false;
        });
      } else if (_controller.offset < _bannerHeight - kToolbarHeight &&
          _showTitle.value) {
        _showTitle.value = false;
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _showTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _bannerHeight = MediaQuery.of(context).size.height * 3 / 11;
    return ProviderWidget<HomeModel>(
      model: HomeModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isError) {
          return ViewStateErrorWidget(
            error: model.errorMessage,
            onPressed: model.initData(),
          );
        }
        return Scaffold(
            body: SmartRefresher(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              footer: ClassicFooter(
                loadingText: "加载中...",
                failedText: "加载失败",
                noDataText: "没数据了",
              ),
              enablePullUp: true,
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    actions: <Widget>[
                      ValueListenableBuilder(
                        valueListenable: _showTitle,
                        builder: (context, value, child) {
                          if (value) {
                            return IconButton(icon: Icon(Icons.search), onPressed: search);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                    expandedHeight: _bannerHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Banner(
                        model: model,
                      ),
                      centerTitle: true,
                      title: ValueListenableBuilder(
                        valueListenable: _showTitle,
                        builder: (context, value, child) {
                          if (value) {
                            return Text("首页");
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  if (model.top?.isNotEmpty ?? false)
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ArticleItemWidget(
                          article: model.top[index],
                          isTop: true,
                        );
                      },
                      childCount: model.top?.length ?? 0,
                    )),
                  HomeArticleList(),
                ],
              ),
            ),
            floatingActionButton: _showButton
                ? FloatingActionButton(
                    child: Icon(Icons.search), onPressed:search)
                : null);
      },
    );
  }

  void search(){
    showSearch(context: context, delegate: MySearchDelegate());
  }

  @override
  bool get wantKeepAlive => true;
}

class Banner extends StatelessWidget {
  final HomeModel model;

  const Banner({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
              Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.white10),
        ),
      );
    }
    List banners = model?.banner ?? [];
    return Swiper(
      itemCount: banners.length,
      duration: 1000,
      autoplayDelay: 5000,
      pagination: SwiperPagination(),
      loop: true,
      autoplay: true,
      itemBuilder: (context, index) => InkWell(
        child: CachedNetworkImage(
            imageUrl: ImageHelper.wrapUrl(banners[index].imagePath),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill),
        onTap: () {
          var banner = banners[index];
          Navigator.of(context).pushNamed(RouteName.ARTICLE_DETAIL,
              arguments: Article()
                ..id = banner.id
                ..title = banner.title
                ..link = banner.url
                ..collect = false);
        },
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.isLoading) {
      return SliverToBoxAdapter(
        child: SkeletonList(),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Article item = homeModel.list[index];
          return ArticleItemWidget(
            article: item,
          );
        },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }
}
