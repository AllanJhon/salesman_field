import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route.dart';
import 'routers/application.dart';
import 'routers/routers.dart';
import 'service/customer_api.dart';
import 'env.dart';
import 'untils/provider.dart';
import 'untils/shared_preferences.dart';

const int ThemeColor = 0xFFC91B3A;
SpUtil sp;
var db;

void main() async{
  Env.apiClient = CustomerAPI();
  final provider = new Provider();
  await provider.init(true);
  sp = await SpUtil.getInstance();
  // new SearchHistoryList(sp);
  db = Provider.db;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  MyApp()  {
    final router = new Router();

    Routes.configureRoutes(router);

    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(ThemeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: Color(ThemeColor),
          size: 35.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: LoginPageZ(), //Tabs(),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
