import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_shop/iconfont/icon_font.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Catdown extends StatefulWidget {
  var list;
  Catdown(this.list);
  @override
  _CatdownState createState() => _CatdownState(list);
}

class _CatdownState extends State<Catdown> {
  var lister;
  _CatdownState(this.lister);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '作者名字:' + lister['user_name'],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: lister['url_image'],
              width: width,
              height: ScreenUtil().setHeight(920.0),
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(500, 187, 143, 195),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(98.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Text(
                  '${lister['width']}' + 'x' + '${lister['height']}',
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
            child: Image.asset(
              "assets/motorcycle.jpg",
              width: width,
              height: ScreenUtil().setHeight(175.0),
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
        await NetworkAssetBundle(Uri.parse(lister['url_image'])).load("");
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
