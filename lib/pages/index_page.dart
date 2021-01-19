import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

//底部导航
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('用户中心')),
  ];
  final List<Widget> tabBodies = [HomePage(), CategoryPage(), MemberPage()];
  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    super.initState();
    super.build(context);
    currentPage = tabBodies[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    DateTime lastPopTime;
    return WillPopScope(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            //类型
            backgroundColor: Color.fromARGB(100, 187, 143, 195),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                currentPage = tabBodies[currentIndex];
              });
            },
          ),
          //保存页面状态
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          )),
      //再按一次退出行为
      onWillPop: () {
        // 点击返回键的操作
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(
              msg: "再按一次退出",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Theme.of(context).accentColor,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          lastPopTime = DateTime.now();

          // 退出app
          exit(0);
        }
      },
    );
  }
}
