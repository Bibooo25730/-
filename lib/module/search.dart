import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/apikey.dart';
import 'search_down.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//搜索
class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    String hintText = '描述',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  List tpitem = [];
  var item;
  Future search() async {
    try {
      Response response;
      response = await Dio().get(
          'https://wall.alphacoders.com/api2.0/get.php?auth=' +
              ApiKey +
              '&method=search&term=${query}');
      if (response.statusCode == 200) {
        item = response.data;
        if (item["total_match"] != "0") {
          tpitem = item['wallpapers'];
          print(tpitem);
          return tpitem;
        } else {
          tpitem = item["total_match"];
          print(tpitem);
        }
      }
    } catch (e) {
      print('Erro---------------接口错误');
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    //FutureBuilder异步UI更新//AsyncSnapshot状态快照
    return FutureBuilder(
        future: search(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.pink[100],
              child: ListView.builder(
                  itemCount: tpitem.length,
                  itemBuilder: (BuildContext zxc, int i) {
                    var Siem = tpitem[i];

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SerachDown(Siem)));
                          },
                          child: Wrap(
                            children: [
                              Container(
                                  height: ScreenUtil().setHeight(400.0),
                                  padding: EdgeInsets.only(top: 20.0),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FadeInImage.assetNetwork(
                                        placeholder: 'assets/img/thumb.jpg',
                                        width: ScreenUtil().setWidth(550.0),
                                        height: ScreenUtil().setHeight(3000.0),
                                        image: Siem['url_thumb'],
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }

          return Center(
              child: CircularProgressIndicator(
                  strokeWidth: 15,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[100])));
        }
        //进度条
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 50.0),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              '因接口是国外的,所以搜索请用英文',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ));
  }

  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(primaryColor: Colors.pink[50]);
  }
}
