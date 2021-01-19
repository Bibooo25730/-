import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'apikey.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_shop/r.dart';
import 'package:permission_handler/permission_handler.dart';

//推荐图片
class DioHttp extends StatefulWidget {
  DioHttp({Key key}) : super(key: key);

  @override
  _DioHttpState createState() => _DioHttpState();
}

class _DioHttpState extends State<DioHttp> with SingleTickerProviderStateMixin {
  //控制动画执行时间
  AnimationController _controller;
  //电话
  Animation _animation;
  String jsonString;
  var item;
  bool rating;
  String ratiJson;
  var dylisr = [];
  String jsonb;
  @override
  void initState() {
    rating = true;
    _dacdr();
    _ratin();
    SpUtil.getInstance();
    super.initState();
    var permission =
        PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    print("权限状态为 " + permission.toString());
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage, // 在这里添加需要的权限
    ]);

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    //animate动画使用了动画控制器的约定
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    //动画监听事件
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IndexPage()),
            (route) => route == null);
      }
    });

    //播放动画
    _controller.forward();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
    //网络请求
    getHTTP();
    // _dacdr();
  }

  // String id = '111';
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750.0, 1334.0), allowFontScaling: false);
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                R.assetsImgTimgs,
                fit: BoxFit.cover,
                height: hight,
              ),
            ),
            Container(
                height: ScreenUtil().setHeight(1000.0),
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(240.0)),
                alignment: Alignment.center,
                child: SizedBox(
                  child: ColorizeAnimatedTextKit(
                    speed: Duration(milliseconds: 1500),
                    alignment: Alignment.center,
                    onTap: () {
                      print('Err---------');
                    },
                    text: ['Bibooo搜图'],
                    textStyle: TextStyle(fontSize: 50.0, fontFamily: 'Horizon'),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _dacdr() {
    getHTTP().then((val) => {
          item = (val['wallpapers']),
          jsonString = json.encode(item),
          SpUtil.putString('tpdata', (jsonString)),
          rating = false
        });
  }

  //首页推荐的图片请求
  Future getHTTP() async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.get(
          'https://wall.alphacoders.com/api2.0/get.php?auth=' +
              ApiKey +
              '&method=newest&page=1&info_level=2');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      return print('Error-------------->${e}');
    }
  }

  _ratin() {
    ratiDate().then((value) => {
          dylisr = value['wallpapers'],
          jsonb = json.encode(dylisr),
          SpUtil.putString('jxdate', (jsonb)),
          rating = false
        });
  }

  //接受ratingjson
  Future ratiDate() async {
    try {
      Response response;
      response = await Dio().get(
          'https://wall.alphacoders.com/api2.0/get.php?auth=' +
              ApiKey +
              '&method=highest_rated&page=1&info_level=1');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('Erro===========接口错误');
    }
  }
}
