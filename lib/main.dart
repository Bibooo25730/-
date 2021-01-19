import 'package:flutter/material.dart';

import 'config/dio_url.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bibooo搜图',
      debugShowCheckedModeBanner: false,
      //主题

      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      home: DioHttp(),
    );
  }
}
