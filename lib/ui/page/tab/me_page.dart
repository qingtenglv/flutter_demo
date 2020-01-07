import 'package:demo/config/resource_mananger.dart';
import 'package:demo/config/router_manager.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/view_model/coin_model.dart';
import 'package:demo/view_model/theme_model.dart';
import 'package:demo/view_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MeState();
  }
}

class MeState extends State<MePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          HeadWidget(),
          ListWidget(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HeadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    UserModel model = Provider.of<UserModel>(context);
    return InkWell(
      onTap: () {
        if (!model.hasUser) {
          Navigator.pushNamed(context, RouteName.LOGIN);
        }
      },
      child: Container(
        height: 200,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  ImageHelper.connectAssets("cxk.jpg"),
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Builder(builder: (context) {
                  return Text(
                    model.hasUser
                        ? "昵称:${model.user.nickname}\n\nid:${model.user.id}"
                        : "请先登录~\n\nid:--",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: textColor,
                    ),
                  );
                })
              ],
            ),
            Spacer(),
            Offstage(
              offstage: !model.hasUser,
              child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("是否确认注销？"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      model.clearUser();
                                      Navigator.pop(context);
                                    },
                                    child: Text("注销")),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("取消"),
                                ),
                              ],
                            ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.white10,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      margin: EdgeInsets.only(top: 200),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("我的积分"),
            leading: Icon(
              Icons.monetization_on,
              color: iconColor,
            ),
            trailing: SizedBox(
              width: 200,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (Provider.of<UserModel>(context).hasUser) CoinWidget(),
                    Icon(Icons.keyboard_arrow_right)
                  ]),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.COIN_RANK,
                  arguments: Provider.of<UserModel>(context).hasUser);
            },
          ),
          ListTile(
            title: Text("我的收藏"),
            leading: Icon(
              Icons.favorite_border,
              color: iconColor,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.COLLECT,
                  arguments: Provider.of<UserModel>(context).hasUser);
            },
          ),
          ListTile(
            title: Text("黑夜模式"),
            leading: Icon(
              Icons.settings,
              color: iconColor,
            ),
            trailing: Switch(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  switchThemeModel(context, value);
                }),
          ),
          SettingWidget(),
        ],
      ),
    );
  }

  void switchThemeModel(BuildContext context, bool value) {
    Provider.of<ThemeModel>(context).switchThemeMode(isDarkMode: value);
  }
}

class CoinWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CoinModel>(
      model: CoinModel(),
      onModelReady: (model) => model.getCoinCount(),
      builder: (context, model, child) {
        return Text("当前积分：" + model.count.toString(),
            style: Theme.of(context).textTheme.caption);
      },
    );
  }
}

class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("色彩主题"),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: Colors.primaries
              .map(
                (color) => InkWell(
                  child: Container(
                    color: color,
                    width: 40,
                    height: 40,
                  ),
                  onTap: () {
                    Provider.of<ThemeModel>(context)
                        .switchThemeMode(themeColor: color);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
