import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:saller_demo01/pages/contract/ContractAddPage.1.dart';

import 'package:saller_demo01/pages/contract/ContractAddPage.dart';
import 'package:saller_demo01/pages/contract/ContractDetailAddPage.dart';
import 'package:saller_demo01/pages/contract/customerChoosePage.dart';
import 'package:saller_demo01/pages/customer/CustomerPage.dart';
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
    String name = params["type"][0];
    if(name=='contract')
      
      return new ContractAddPage1();
    else if(name=='chooseCustomer'){
      return new CustomerChoosePage();
    }else
      return new ContractDetailAddPage();
  },
);

var customerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String name = params["type"][0];
    if(name=='list')
      return new CustomerPage();
    else{
      return new ContractDetailAddPage();
    }
  },
);

var widgetNotFoundHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new WidgetNotFound();
});