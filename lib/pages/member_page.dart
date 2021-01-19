import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UsetIamg(),
          Titlebug(),
          XianT(),
          Login(),
        ],
      ),
    );
  }
}

//用户
class UsetIamg extends StatefulWidget {
  UsetIamg({Key key}) : super(key: key);

  @override
  _UsetIamgState createState() => _UsetIamgState();
}

class _UsetIamgState extends State<UsetIamg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0.0),
      width: ScreenUtil().setWidth(800.0),
      height: ScreenUtil().setHeight(500.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),

// 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
        boxShadow: [
          BoxShadow(
              offset: Offset(2.0, 2.0), blurRadius: 10.0, spreadRadius: 2.0),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print("");
            },
            child: Container(
              child: Image.asset(
                'assets/girl.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("未登录",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.pink[400],
                )),
          )
        ],
      ),
    );
  }
}

class Titlebug extends StatelessWidget {
  const Titlebug({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Center(
        child: Text(
          "更多功能",
          style: TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }
}

class XianT extends StatelessWidget {
  const XianT({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Divider(
        height: 5,
        color: Colors.blueGrey,
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            "assets/beuj.jpg",
            width: width,
            height: ScreenUtil().setHeight(580.0),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            right: 20.0,
            top: 80.0,
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(600.0),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
              )),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                  fillColor: Colors.red,
                  prefixIcon: Icon(Icons.person),
                  labelText: '账号',
                ),
              ),
            ))
      ],
    );
  }
}
