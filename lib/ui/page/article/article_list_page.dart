import 'package:demo/config/resource_mananger.dart';
import 'package:demo/config/router_manager.dart';
import 'package:demo/model/article.dart';
import 'package:demo/provider/view_state_list_refresh_model.dart';
import 'package:demo/ui/page/me/login_page.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/ui/widget/skeleton_widget.dart';
import 'package:demo/ui/widget/view_state_widget.dart';
import 'package:demo/view_model/favorite_model.dart';
import 'package:demo/view_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/strings.dart';

class ArticleListPage extends StatefulWidget {
  final ViewStateListRefreshModel<Article> model;

  ArticleListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return ArticleListState();
  }
}

class ArticleListState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<ViewStateListRefreshModel<Article>>(
      model: widget.model,
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isLoading) {
          return SkeletonList();
        } else if (model.isError) {
          return ViewStateErrorWidget(
              error: model.errorMessage, onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget();
        }
        return SmartRefresher(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          footer: ClassicFooter(
            loadingText: "加载中...",
            failedText: "加载失败",
            noDataText: "没数据了",
          ),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) =>
                ArticleItemWidget(article: model.list[index]),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final bool isTop;

  const ArticleItemWidget({Key key, this.article, this.isTop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle caption = Theme.of(context).textTheme.caption;
    TextStyle subhead = Theme.of(context).textTheme.subhead;
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.ARTICLE_DETAIL,
            arguments: article);
      },
      child: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  isNotBlank(article.author)
                      ? article.author
                      : article.shareUser ?? "",
                  style: caption,
                ),
                if (isTop)
                  Container(
                    margin: EdgeInsets.only(left: 6),
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(border: Border.all(color: Colors.redAccent,width: 1)),
                    child: Text(
                      "置顶",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                Spacer(),
                Text(
                  article.niceDate,
                  style: caption,
                ),
              ],
            ),
            Builder(builder: (context) {
              if (article.envelopePic.isEmpty) {
                return Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    article.title,
                    style: subhead,
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              article.title,
                              style: subhead,
                              maxLines: 2,
                            ),
                            Text(
                              article.desc,
                              style: caption,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                      Expanded(
                          flex: 1,
                          child: WrapperImage(
                              url: article.envelopePic,
                              width: 100,
                              height: 100)),
                    ],
                  ),
                );
              }
            }),
            Row(
              children: <Widget>[
                Text(
                  isNotBlank(article.superChapterName)
                      ? article.chapterName + "·" + article.superChapterName
                      : article.chapterName,
                  style: caption,
                ),
                Spacer(),
                article.collect == null
                    ? SizedBox.shrink()
                    : Consumer<FavoriteChangeModel>(
                        builder: (context, model, child) {
                          if (model.getFavorite(article.id) == null) {
                            return child;
                          }
                          return FavoriteButton(
                              article: article
                                ..collect = model.getFavorite(article.id));
                        },
                        child: FavoriteButton(article: article),
                      ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class FavoriteButton extends StatelessWidget {
  final Article article;

  const FavoriteButton({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavoriteModel>(
      model: FavoriteModel(Provider.of(context)),
      builder: (context, model, child) {
        return InkWell(
            child: Icon(
              article.collect && Provider.of<UserModel>(context).hasUser
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onTap: () {
              if (Provider.of<UserModel>(context).hasUser) {
                model.collect(article);
              } else {
                Navigator.pushNamed(context, RouteName.LOGIN);
              }
            });
      },
    );
  }
}
