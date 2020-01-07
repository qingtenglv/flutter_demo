import 'package:flutter/material.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'square_page.dart';
import 'gongzhonghao_page.dart';
import 'me_page.dart';
import 'package:oktoast/oktoast.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  ProjectPage(),
  SquarePage(),
  GongPage(),
  MePage(),
];

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabState();
  }
}

class TabState extends State<TabNavigator> {
  PageController _pageController = new PageController();
  int _selectIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            if (_lastPressed == null ||
                DateTime.now().difference(_lastPressed) >
                    Duration(seconds: 1)) {
              _lastPressed = DateTime.now();
              showToast("再按一次退出APP");
              return false;
            }
            return true;
          },
          child: PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index){
                setState(() {
                  _selectIndex=index;
                });
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text("项目")),
          BottomNavigationBarItem(icon: Icon(Icons.call_split), title: Text("广场")),
          BottomNavigationBarItem(icon: Icon(Icons.child_care), title: Text("公众号")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _selectIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
