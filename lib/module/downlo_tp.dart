import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/apikey.dart';
import 'package:flutter_shop/module/catedown.dart';

class Categorydow extends StatefulWidget {
  final itemtp;
  Categorydow(this.itemtp);

  @override
  _CategorydowState createState() => _CategorydowState(itemtp);
}

class _CategorydowState extends State<Categorydow> {
  @override
  void initState() {
    super.initState();
  }

  var item;
  var fentu;
  List<dynamic> plad;
  _CategorydowState(this.item);
  Future getCate() async {
    Response response;
    try {
      response = await Dio().get(
          'https://wall.alphacoders.com/api2.0/get.php?auth=${ApiKey}&method=category&id=${item['id']}&page=1&info_level=2');
      if (response.statusCode == 200) {
        var yshuTp = response.data;
        fentu = yshuTp['wallpapers'];

        return fentu;
      }
    } catch (e) {
      return print("Error------------分类错误接口");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCate(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "加载中",
                  style: TextStyle(
                      decoration: TextDecoration.none, fontSize: 20.0),
                ),
              ),
            );
          } else if (snapShot.connectionState == ConnectionState.done) {
            plad = snapShot.data;

            if (snapShot.hasError) {
              return Text("Error:${snapShot.error}");
            }
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(item['name']),
            ),
            body: Crsear(
              lister: plad,
            ),
          );
        });
  }
}

//分类lgin

// ignore: must_be_immutable
class Crsear extends StatelessWidget {
  List<dynamic> lister;
  Crsear({Key key, this.lister}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: lister
            .map((e) => Container(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Catdown(e)));
                  },
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/flai.jpg',
                    height: ScreenUtil().setHeight(340.0),
                    image: e['url_thumb'],
                    fit: BoxFit.fill,
                  ),
                )))
            .toList(),
      ),
    );
  }
}
