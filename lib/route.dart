import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'tabs.dart';
import 'loginPage.dart';
import 'loginPageZ.dart';
import 'pages/bill/billPage.dart';
import 'pages/bill/billDetail.dart';
import 'pages/bill/billSearch.dart';
import 'pages/home/homePage.dart';
import 'pages/customer/CustomerPage.dart';
import 'pages/404.dart';
import 'view/homePage1.dart';
import 'pages/contract/ContractAddPage.dart';
import 'pages/contract/ContractDetailAddPage.dart';

//以下为测试页面
import 'view/businessPage.dart';
import 'view/customerPage.dart';
// import 'view/homePage1.dart';

final routes = {
  '/home': (content) => HomePageWidget(),
  '/billD': (content, {arguments}) => BillDetail(arguments: arguments),
  '/login': (content) => LoginPage(),
  '/': (content,{arguments}) => LoginPageZ(),
  '/tabs': (content) => Tabs(),
  '/billSearch': (content) =>BillSearch(),
  '/bill': (content,{arguments}) =>BillPage(arguments: arguments),
  '/customer': (content) =>CustomerPage(),
  '/404': (content) =>WidgetNotFound(),
  '/contractAdd':(content) => ContractAddPage(),
  '/conDetailAdd':(content) => ContractDetailAddPage(),
  '/cDA':(content) => ContractDetailAddPage(),
  //以下为测试用页面

   '/busi': (content) =>BusinessPageWidget(),
   '/cust': (content) =>CustomerPageWidget(),
   '/hm1': (content) =>HomePageTest(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
