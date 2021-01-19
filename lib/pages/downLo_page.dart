import 'package:flutter/material.dart';
import 'package:flutter_shop/iconfont/icon_font.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//最新图片下载
// ignore: must_be_immutable
class DownLoPage extends StatefulWidget {
  var item;
  DownLoPage(
    this.item,
  );

  @override
  _DownLoPageState createState() => _DownLoPageState(item);
}

class _DownLoPageState extends State<DownLoPage> {
  var tpitem;

  _DownLoPageState(this.tpitem);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //文字渐变
    Gradient gradient = LinearGradient(colors: [
      Colors.blueAccent,
      Colors.greenAccent,
    ]);
    // 获取屏幕大小,创建shader指定rect范围时需要
    Size size = MediaQuery.of(context).size;
    //获取屏幕宽度
    double width = MediaQuery.of(context).size.width;
    // 根据渐变创建shader
// 范围是从左上角(0,0),到右下角(size.width,size.height)全屏幕范围
    Shader shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(500, 187, 143, 195),
        title: Text(
          tpitem['sub_category'],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            width: width,
            height: ScreenUtil().setHeight(1020.0),
            imageUrl: tpitem['url_image'],
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
                  '${tpitem['width']}' + 'x' + '${tpitem['height']}',
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
            child: Text(
              '艺术由${tpitem['user_name']}制作',
              style: TextStyle(
                fontSize: 18.0,
                foreground: Paint()..shader = shader,
              ),
            ),
          ),
          Container(
            child: Text(
              '作者ID:${tpitem['user_id']}',
              style: TextStyle(
                fontSize: 18.0,
                foreground: Paint()..shader = shader,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //下载
  _testSaveImg() async {
    Fluttertoast.showToast(msg: '下载中');
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(tpitem['url_image'])).load("");
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
