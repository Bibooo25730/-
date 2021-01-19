import 'dart:convert';
import 'downLo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/apikey.dart';
import 'package:flutter_shop/iconfont/icon_font.dart';
import 'package:flutter_shop/r.dart';
import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shop/config/sargi.dart';
import 'downLo_page.dart';
import 'package:flutter_shop/module/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<dynamic> item;
  List<dynamic> lister;
  String jxDate;
  bool rating;
  @override
  void initState() {
    super.initState();
    rating = true;
    fetchData();
    rddati();
  }

  //接受itemJson
  fetchData() async {
    String tpDate = SpUtil.getString("tpdata");
    if (tpDate != '') {
      item = json.decode(tpDate);
      rating = false;
      SpUtil.remove(tpDate);
      // } else {
      // try {
      //   Response response;
      //   response = await Dio().get(
      //       'https://wall.alphacoders.com/api2.0/get.php?auth=' +
      //           ApiKey +
      //           '&method=newest&page=1&info_level=2');

      //   if (response.statusCode == 200) {
      //     item = response.data;
      //     return item;
      //   }
      // } catch (e) {
      //   print('Erro===========接口错误0');
      // }
    }
  }

  //接受精选json
  rddati() async {
    jxDate = SpUtil.getString('jxdate');
    if (jxDate != '') {
      lister = json.decode(jxDate);
      rating = false;
      SpUtil.remove(jxDate);
      // } else {
      //   try {
      //     Response response;
      //     response = await Dio().get(
      //         'https://wall.alphacoders.com/api2.0/get.php?auth=' +
      //             ApiKey +
      //             '&method=highest_rated&page=1&info_level=1');

      //     if (response.statusCode == 200) {
      //       return response.data;
      //     }
      //   } catch (e) {
      //     print('Erro===========接口错误1${e}');
      //   }
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ThemeData(
      primaryColor: Colors.grey,
    );

    return rating
        ? Sargi()
        : Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        child: Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            R.assetsImgGravity,
                            height: ScreenUtil().setHeight(400.0),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 195.0,
                      left: 40.0,
                      right: 40.0,
                      child: Opacity(
                        opacity: 0.3,
                        child: RaisedButton(
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                Text(
                                  '搜索图片',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            }),
                      ),
                    ),
                  ],
                ),
                // 可滚动组件
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          color: Colors.orange[50],
                          child: Row(
                            children: [
                              Container(
                                child: IconFont(
                                  IconNames.icon_tupian,
                                  size: 40.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  '最新图片',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color:
                                          Color.fromARGB(500, 187, 143, 195)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(320.0),
                          child: ListView.builder(
                              itemCount: item.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext zxc, int i) {
                                var items = item[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DownLoPage(items)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/img/homse.jpg',
                                      image: items['url_thumb'],
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          color: Color.fromARGB(80, 223, 196, 120),
                          child: Row(
                            children: [
                              Container(
                                  child: IconFont(
                                IconNames.icon_tupian_1,
                                size: 40.0,
                                color: '#DFC477',
                              )),
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  '精选图片',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color:
                                          Color.fromARGB(500, 223, 196, 120)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(320.0),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: lister
                                  .map((e) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DouWnJxuan(e)));
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/img/star.jpg',
                                            image: e['url_thumb'],
                                            width: 300.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ))))
                                  .toList()),
                        ),
                        Container(
                            color: Colors.pink[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('本站所有内容由'),
                                FlatButton(
                                    child: Text(
                                      'Abyss Wallpaper',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () async {
                                      const url =
                                          'https://wall.alphacoders.com/';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not lauch $url';
                                      }
                                    }),
                                Text('提供动力'),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
  }
}
