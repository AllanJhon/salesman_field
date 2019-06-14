
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:saller_demo01/pages/index.dart';
import 'package:saller_demo01/untils/analytics.dart';

import './router_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String widgetDemo = '/widget-demo';
  static String codeView = '/code-view';
  static String webViewPage = '/web-view-page';

  static void configureRoutes(Router router) {
    List widgetDemosList = new WidgetDemoList().getDemos();
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        });
    router.define(home, handler: homeHandler);
    router.define("/pages/contract/ContractAddPage",handler:contractHandler);
    router.define('/contract/:type', handler: contractHandler);
    router.define('/customer/:type', handler: customerHandler);
    router.define('/category/error/404', handler: widgetNotFoundHandler);
    // router.define(codeView,handler:fullScreenCodeDialog);
    // router.define(webViewPage,handler:webViewPageHand);
      widgetDemosList.forEach((demo) {
        Handler handler = new Handler(
            handlerFunc: (BuildContext context, Map<String, List<String>> params) {
              print('组件路由params=$params widgetsItem=${demo.routerName}');
              analytics.logEvent(
                  name: 'component', parameters: {'name': demo.routerName });
              return demo.buildRouter(context);
      });
      router.define('${demo.routerName}', handler: handler);
    });
  }
}
