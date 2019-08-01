import 'package:flutter/material.dart';
import '../theme/color.dart';

class AppTheme {
  static int mainColor = 0xFFC91B3A;//materialColor['red'];
static getThemeData(String theme) {
    mainColor = materialColor[theme];
    ThemeData themData = ThemeData(
      textTheme: TextTheme(
        body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
      ),
      //platform: TargetPlatform.iOS,
      iconTheme: IconThemeData(
        size: 32,
        color: Color(mainColor),
        opacity: 0.85,
      ),
      // primaryIconTheme 导航栏按钮颜色
      primaryIconTheme: IconThemeData(
        color: Color(mainColor),
      ),
      accentColor: Color(0xFF888888),
      primaryColor: Color(mainColor), // appbar背景
      
      primaryTextTheme: TextTheme(
          title: TextStyle(
              // color: Colors.red
              ),
          button: TextStyle(color: Colors.red)),
    );
    return themData;
  }
}