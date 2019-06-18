/// @Author: 一凨 
/// @Date: 2018-12-17 13:16:29 
/// @Last Modified by: 一凨
/// @Last Modified time: 2018-12-17 13:43:01

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BoxScrollView extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final Color color;

  // 所有的可用demos;
  BoxScrollView(
      {Key key,
      this.children = const <Widget>[],
      this.height=50.0,
      this.color=Colors.white,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('滚动一下就看看吧 s(￣▽￣)~*'),
          Container(
            height: 300.0,
            child: Container(
            ),
          )
        ],
      ),
    );
  }
}
