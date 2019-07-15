import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'tabs.dart';
import 'pages/bill/billPage.dart';
import 'pages/bill/billDetail.dart';
import 'pages/bill/billSearch.dart';
import 'pages/home/homePage.dart';
import 'pages/customer/CustomerPage.dart';
import 'pages/404.dart';
import 'pages/contract/ContractAddPage.1.dart';
import 'pages/contract/ContractDetailAddPage.dart';
import 'pages/bill/goodsCodePage.dart';
import 'pages/bill/goodsCodePage-1.dart';
import 'pages/contract/contractQuery.dart';
import 'pages/contract/contractQuerySearch.dart';
import 'pages/customer/CustomerDetail.dart';
import 'pages/my/password.dart';
import 'pages/my/myPage.dart';

import 'pages/bill/billPageNew.dart';

//以下为测试页面
import 'view/businessPage.dart';
import 'view/myTest.dart';
// import 'view/myClipper.dart';
// import 'view/homePage1.dart';

final routes = {
  '/home': (content) => HomePageWidget(),
  '/billD': (content, {arguments}) => BillDetail(arguments: arguments),
  '/login': (content) => LoginPage(),
  '/': (content) => LoginPage(),
  '/tabs': (content) => Tabs(),
  '/billSearch': (content) => BillSearch(),
  '/bill': (content, {arguments}) => BillPage(arguments: arguments),
  '/customer': (content) => CustomerPage(),
  '/404': (content) => WidgetNotFound(),
  '/contractQuery': (content) => ContractQuery(),
  '/conDetailAdd': (content) => ContractDetailAddPage(),
  '/cDA': (content) => ContractDetailAddPage(),
  '/goods': (content) => GoodsCodePage(),
  '/goods1': (content) => GoodsCodePage1(),
  '/contract/contract': (content) => ContractAddPage1(),
  '/contractQuerySearch': (content) => ContractQuerySearch(),
  '/customerDetail': (content, {arguments}) => CustomerDetail(arguments: arguments),
  '/password': (content) => Password(),
  '/my': (content) => MyPage(),
  '/billN': (content, {arguments}) => BillPageNew(arguments: arguments),

  //以下为测试用页面

  '/busi': (content) => BusinessPageWidget(),
  '/test': (content) => Test(),
  // '/arc': (content) => ArcBannerImage(),
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
