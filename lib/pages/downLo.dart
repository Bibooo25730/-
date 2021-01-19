import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:flutter_shop/iconfont/icon_font.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/services.dart';

//精选图片下载
// ignore: must_be_immutable
class DouWnJxuan extends StatefulWidget {
  var jxItem;
  DouWnJxuan(this.jxItem);

  @override
  _DouWnJxuanState createState() => _DouWnJxuanState(jxItem);
}

class _DouWnJxuanState extends State<DouWnJxuan> {
  var jxIt;
  _DouWnJxuanState(this.jxIt);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(100, 106, 90, 205),
        centerTitle: true,
        title: Text('精选图片'),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            width: width,
            height: ScreenUtil().setHeight(1020.0),
            imageUrl: jxIt['url_image'],
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(500, 187, 143, 195),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            height: ScreenUtil().setHeight(80.0),
            width: width,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Text(
                  '${jxIt['width']}' + 'x' + '${jxIt['height']}',
                  style: TextStyle(color: Colors.white),
                )),
                Container(
                    child: IconButton(
                        icon: IconFont(IconNames.icon_xiazai),
                        onPressed: () {
                          _testSaveImg();
                        })),
                Container(
                  child: IconButton(
                      icon: IconFont(
                        IconNames.icon_zhuanfa,
                        color: '#ffffff',
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "目前只支持微信分享抱歉😪");
                        _showBottom();
                      }),
                )
              ],
            ),
          ),
          Container(
            width: width,
            height: ScreenUtil().setHeight(100.0),
            child: Image.asset(
              'assets/img/mb.jpg',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  //下载
  _testSaveImg() async {
    Fluttertoast.showToast(msg: '下载中');
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(jxIt['url_image'])).load("");
    final result =
        await ImageGallerySaver.saveImage(imageData.buffer.asUint8List());
    if (result != '') {
      Fluttertoast.showToast(msg: '下载路径' + '${result}');
    }
  }

  //转发
  _showBottom() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          double height = 80;
          return SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: IconFont(IconNames.icon_weixin),
                      onPressed: () {},
                    ),
                    Text(
                      "微信",
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: IconFont(IconNames.icon_pengyouquan),
                      onPressed: () {},
                    ),
                    Text(
                      "朋友圈",
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: IconFont(IconNames.icon_qq),
                      onPressed: () {},
                    ),
                    Text(
                      "QQ",
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: IconFont(IconNames.icon_q_qkongjian),
                      onPressed: () {},
                    ),
                    Text(
                      "空间",
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
