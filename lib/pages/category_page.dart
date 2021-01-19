import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apifm/apifm.dart' as Apifm;
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/apikey.dart';
import 'package:flutter_shop/module/downlo_tp.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  List<dynamic> cotera = [];

  @override
  void initState() {
    Apifm.init("Bibooo25730");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDatas(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("加载中"),
            );
          } else if (snapShot.connectionState == ConnectionState.done) {
            cotera = snapShot.data;

            if (snapShot.hasError) {
              return Text("Error:${snapShot.error}");
            }
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("发现好壁纸"),
                centerTitle: true,
              ),
              body: Column(
                children: [SwiperDiy(cotera[0]), CoteGory(cotera[1])],
              ));
        });
  }

  Future getDatas() async {
    return Future.wait([banners(), getCote()]);
  }

  Future banners() async {
    var res = await Apifm.banners();

    if (res['code'] == 0) {
      List<String> _imageList = [];
      res['data'].forEach((pic) {
        _imageList.add(pic['picUrl']);
      });

      return _imageList;
    }
  }
}

Future getCote() async {
  try {
    Response response;
    response = await Dio().get(
        "https://wall.alphacoders.com/api2.0/get.php?auth=" +
            ApiKey +
            "&method=category_list");
    var coll = response.data;

    List<dynamic> listDynamic = (coll['categories']);

    return listDynamic;
  } catch (e) {
    return print("分类接口错误+${e}");
  }
}

//轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy(this.swiperDateList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350.0),
      width: ScreenUtil().setWidth(750.0),
      child: Swiper(
        autoplay: true,
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            (swiperDateList[index]),
            fit: BoxFit.fill,
          );
        },
        //导航轮播·
        pagination: SwiperPagination(),
      ),
    );
  }
}

//分类
class CoteGory extends StatelessWidget {
  List<dynamic> cote = [];
  CoteGory(this.cote);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: ScreenUtil().setHeight(750.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          children: cote
              .map((e) => Container(
                    color: Color.fromARGB(100, 138, 173, 205),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(10.0, 2.0)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Categorydow(e)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(e['name']),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
