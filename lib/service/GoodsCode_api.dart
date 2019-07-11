import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../data/SAPCONST.dart';
import '../models/goodsCode.dart';

class GoodsCodeAPI {
  static Future<GoodsCode> getGoodsCodeList(String search) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr =
        '<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER><ZSEND_NO>' +
            search +
            '</ZSEND_NO></ZIF_BH_ORDER>]]>';
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
    var response = await http.post(Uri.parse(getSAPURL("Zif_WQ_IN_WS")),
        headers: getSAPHeader("Zif_WQ_IN_WS"),
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));
    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
      return null;
    }
    var document = xml.parse(response.body);
    var outputxmlstr = document.findAllElements('OUTPUTXMLSTR').single.text;
    return GoodsCode.xml2List(outputxmlstr);
  }

  static Future<GoodsResult> sendGoodsCode(GoodsCode goodsCode) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr =
        '<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER><ZSEND_NO>' +
            goodsCode.sendno +
            '</ZSEND_NO></ZIF_BH_ORDER>]]>';
    String soap = '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
        <soapenv:Body>
            <urn:ZIF_WQ_IN_WS>
              <FLAG>YHMXF</FLAG>
             <INPUTXMLSTR>$inputxmlstr</INPUTXMLSTR>
              <SIGN>$md5Sign</SIGN>
              <TS>$timestamp</TS>
            </urn:ZIF_WQ_IN_WS>
        </soapenv:Body>
      </soapenv:Envelope>''';
    var response = await http.post(Uri.parse(getSAPURL("Zif_WQ_IN_WS")),
        headers: getSAPHeader("Zif_WQ_IN_WS"),
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));
    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
    }
    var document = xml.parse(response.body);
    var outputxmlstr = document.findAllElements('OUTPUTXMLSTR').single.text;
    return GoodsResult.xml2List(outputxmlstr);
  }
}
