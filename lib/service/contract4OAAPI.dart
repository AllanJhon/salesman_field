import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/contract4OA.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../data/SAPCONST.dart';

class Contract4OAAPI {
  static Future<Contract4OA> getContractList(
      String sales, String beginDate, String endDate,
      {String customer, String qydw, String contractStatus}) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr = '''<![CDATA[<?xml version="1.0" encoding="UTF-8"?>
            <data>
              <sales>$sales</sales>
              <beginDate>$beginDate</beginDate>
              <endDate>$endDate</endDate>
              <customer>$customer</customer>
              <qydw></qydw>
              <contractStatus>$contractStatus</contractStatus>
            </data>]]>''';
    String soap = '''
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="webservices.jdsn.com">
    <soapenv:Header/>
    <soapenv:Body>
      <web:ArchiveCustomerInfo_SALESAPP>
         <web:timestamp>$timestamp</web:timestamp>
         <web:sign>$md5Sign</web:sign>
         <web:xmlStr>$inputxmlstr</web:xmlStr>
      </web:ArchiveCustomerInfo_SALESAPP>
    </soapenv:Body>
    </soapenv:Envelope>
    ''';
    var response =
        await http.post(Uri.parse(getOAURL() + "/SalesAPPContractInfoService"),
            headers: {
              "Content-Type": "text/xml;charset=UTF-8",
            },
            body: utf8.encode(soap),
            encoding: Encoding.getByName("UTF-8"));

    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
      return null;
    }
    var document = xml.parse(response.body);
    var outputxmlstr = document.findAllElements('ns1:return').single.text;
    print(".....................................................$outputxmlstr");

    return Contract4OA.xml2List(outputxmlstr);
  }
}
