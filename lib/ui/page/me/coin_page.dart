import 'package:demo/config/router_manager.dart';
import 'package:demo/model/coin.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/ui/widget/view_state_widget.dart';
import 'package:demo/view_model/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoinRankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("积分排行"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.COIN_RECORD);
              })
        ],
      ),
      body: ProviderWidget<CoinRankModel>(
        model: CoinRankModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return ViewStateLoadingWidget();
          } else if (model.isError) {
            return ViewStateErrorWidget(error:model.errorMessage,onPressed: model.initData);
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
                  RankItemWidget(map: model.list[index], index: index),
            ),
          );
        },
      ),
    );
  }
}

class RankItemWidget extends StatelessWidget {
  final Map map;
  final int index;

  const RankItemWidget({Key key, this.map, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: BoxConstraints.expand(height: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                (index + 1).toString(),
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Text(
              map["username"],
              style: TextStyle(),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                map["coinCount"].toString(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("积分记录"),
      ),
      body: ProviderWidget<CoinRecordModel>(
        model: CoinRecordModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return ViewStateLoadingWidget();
          } else if (model.isError) {
            return ViewStateErrorWidget(error:model.errorMessage,onPressed: model.initData);
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
                  RecordItemWidget(coin: model.list[index]),
            ),
          );
        },
      ),
    );
  }
}

class RecordItemWidget extends StatelessWidget {
  final Coin coin;

  const RecordItemWidget({Key key, this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      constraints: BoxConstraints.expand(height: 60),
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text(coin.desc),),
          Spacer(),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text("+${coin.coinCount}"),)
        ],
      ),
    ));
  }
}
