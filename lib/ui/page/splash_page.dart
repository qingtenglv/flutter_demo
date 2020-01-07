import 'package:demo/config/resource_mananger.dart';
import 'package:flutter/material.dart';
import 'package:demo/config/router_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed(RouteName.TAB_NAVIGATOR);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Scaffold(
              body: Container(
                color: Theme.of(context).primaryColor,
                child: LogoAnimation(
                  controller: _controller,
                ),
              ),
            );
          }),
      onWillPop: () async {
        return false;
      },
    );
  }
}

// ignore: must_be_immutable
class LogoAnimation extends StatelessWidget {
  final List<Color> _colors = [
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.brown,
    Colors.blue,
    Colors.yellow,
    Colors.black,
    Colors.pink,
    Colors.deepPurple,
    Colors.white
  ];

  final Animation<double> controller;
  Animation<int> colorIndex;
  Animation<double> increase;
  Animation<double> reduce;

  LogoAnimation({Key key, this.controller}) : super(key: key) {
    colorIndex = IntTween(begin: 0, end: _colors.length - 1).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.1, 0.6, curve: Curves.ease)));
    increase = Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.6, 0.75, curve: Curves.ease)));
    reduce = Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.75, 0.9, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        builder: (BuildContext context, Widget child) {
          return Center(
            child: Image.asset(
              ImageHelper.connectAssets("ic_launcher_foreground.png"),
              width: 200 * increase.value / reduce.value,
              height: 200 * increase.value / reduce.value,
              color: _colors[colorIndex.value],
            ),
          );
        },
        animation: controller);
  }
}
