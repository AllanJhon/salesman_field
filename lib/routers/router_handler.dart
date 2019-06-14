import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:saller_demo01/pages/contract/ContractAddPage.1.dart';

import 'package:saller_demo01/pages/contract/ContractAddPage.dart';
import 'package:saller_demo01/pages/contract/ContractDetailAddPage.dart';
import 'package:saller_demo01/pages/home/homePage.dart';
import '../pages/404.dart';

// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePageWidget();
  },
);

var contractHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    // String name = params["type"]?.first;
    String name = params["type"][0];
    if(name=='contract')
      return new ContractAddPage1();
    else{
      return new ContractDetailAddPage();
    }
  },
);

var widgetNotFoundHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new WidgetNotFound();
});

// var fullScreenCodeDialog = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String path = params['filePath']?.first;
//   return new FullScreenCodeDialog(
//     filePath: path,
//   );
// });

// var webViewPageHand = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String title = params['title']?.first;
//   String url = params['url']?.first;
//   return new WebViewPage(url, title);
// });
