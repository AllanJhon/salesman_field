import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/contract/ContractAddPage.1.dart';
import '../pages/contract/ContractDetailAddPage.dart';
import '../pages/contract/customerChoosePage.dart';
import '../pages/customer/CustomerPage.dart';
import '../pages/home/homePage.dart';
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
    }else{
      String informationString = params['informationString']?.first;
      // String takeType = params['takeType']?.first;
      var list = List<int>();
    ///字符串解码
      jsonDecode(informationString).forEach(list.add);
      final String value = Utf8Decoder().convert(list);
      var mapValue = json.decode(value);
      print(mapValue['customerName']);
      return new ContractDetailAddPage(customerName: mapValue['customerName'],takeType:mapValue['takeType']);
    }
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