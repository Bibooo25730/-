import 'package:flutter/material.dart';
import 'package:flutter_shop/iconfont/icon_font.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//搜索下载
// ignore: must_be_immutable
class SerachDown extends StatefulWidget {
  var item;
  SerachDown(this.item);

  @override
  _SerachDownState createState() => _SerachDownState(item);
}

class _SerachDownState extends State<SerachDown> {
  var seraIm;
  _SerachDownState(this.seraIm);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Bibooo搜图"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(500, 255, 228, 225),
        ),
        body: Container(
          color: Colors.white30,
          child: Column(
            children: [
              Container(
                child: CachedNetworkImage(
                  width: width,
                  height: ScreenUtil().setHeight(920.0),
                  imageUrl: seraIm['url_image'],
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
                height: ScreenUtil().setHeight(100.0),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        child: Text(
                      '${seraIm['width']}' + 'x' + '${seraIm['height']}',
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
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  "assets/th.jpg",
                  width: ScreenUtil().setWidth(400.0),
                  height: ScreenUtil().setWidth(190.0),
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ));
  }

  //下载
  _testSaveImg() async {
    Fluttertoast.showToast(msg: '下载中');
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(seraIm['url_image'])).load("");
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
