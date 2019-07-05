import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../untils/HttpUtil.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

// import 'package:second/view/homePage.dart';

var _txt = "124";
List<Widget> _list = new List();

var date = new DateTime.now();
String timestamp =
    "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
String md5Sign =
    md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
String inputxmlstr =
    '<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER><ZSEND_NO>10</ZSEND_NO></ZIF_BH_ORDER>]]>';

class BusinessPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BusinessPageWidgetState();
  }
}

class BusinessPageWidgetState extends State<BusinessPageWidget> {
  Future getData() async {
    // String url = Api.NEWS_LIST;
    String url =
        "http://dstbj.jdsn.com.cn:8081/sap/bc/srt/rfc/sap/zif_wq_in_ws/102/service/binding";
    var data = {
      "TS": timestamp,
      "SIGN": md5Sign,
      "FLAG": "YHMCX",
      "INPUTXMLSTR": inputxmlstr,
      "soapenv":
          'Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions'
    };

    var response = await HttpUtil().post(
      url,
      data: data,
      options: new BaseOptions(
        headers: {
          "SOAPAction":
              "urn:sap-com:document:sap:rfc:functions:Zif_WQ_IN_WS:ZIF_WQ_IN_WSRequest",
          "Content-Type": "text/xml;charset=UTF-8",
          'Authorization': 'Basic VFJGQzAxOjEyMzQ1Ng=='
        },
      ),
      // data: data,
    );

    print(response.toString());
    // responseBody = await response.transform(utf8.decoder).join();
    // Map<String, Object> mapData = json.decode(response.toString());
    setState(() {
      //
    });
    // print(_list.length);
  }

  Future getCustomerList(int start) async {
    String soap = '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
        <soapenv:Body>
            <urn:ZIF_WQ_IN_WS>
              <FLAG>YHMCX</FLAG>
             <INPUTXMLSTR>$inputxmlstr</INPUTXMLSTR>
              <SIGN>$md5Sign</SIGN>
              <TS>$timestamp</TS>
            </urn:ZIF_WQ_IN_WS>
        </soapenv:Body>
      </soapenv:Envelope>''';
    var response = await http.post(
        Uri.parse(
            'http://dstbj.jdsn.com.cn:8081/sap/bc/srt/rfc/sap/zif_wq_in_ws/102/service/binding'),
        headers: {
          "SOAPAction":
              "urn:sap-com:document:sap:rfc:functions:Zif_WQ_IN_WS:ZIF_WQ_IN_WSRequest",
          "Content-Type": "text/xml;charset=UTF-8",
          'Authorization': 'Basic VFJGQzAxOjEyMzQ1Ng=='
        },
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));
    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
    }

    var document = xml.parse(response.body);
    var outputxmlstr = document.findAllElements('OUTPUTXMLSTR').single.text;

    List total = xml
        .parse(outputxmlstr)
        .findAllElements('DATA')
        .map((node) => (node.findElements('SEND_NO').single.text +
            "-" +
            node.findElements('ZFLAG').single.text))
        .toList();

    for (int i = 0; i < total.length; i++) {
      print(total[i].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.vpn_key),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          centerTitle: true,
          title: new Text(
            '订单',
            style: TextStyle(),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                tooltip: '搜索',
                onPressed: () {
                  getCustomerList(0);
                  // getData();
                })
          ],
        ),
        body: new Container(child: Text(md5Sign)));
  }
}
