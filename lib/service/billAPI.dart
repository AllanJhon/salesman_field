import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../data/SAPCONST.dart';
import '../models/billModel.dart';

class BillAPI {
  static Future<BillModel> xml2List(String zksrq, String zjsrq, String zvkbur,
      String zvkgrp, String zkunnr, String zflag, String zbstkd) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr =
        '''<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER>
        <ZKSRQ>$zksrq</ZKSRQ>
        <ZJSRQ>$zjsrq</ZJSRQ>
        <ZVKBUR>$zvkbur</ZVKBUR>
        <ZVKGRP>$zvkgrp</ZVKGRP>
        <ZKUNNR>$zkunnr</ZKUNNR>
        <ZFLAG>$zflag</ZFLAG>
        <ZBSTKD>$zbstkd</ZBSTKD>
       </ZIF_BH_ORDER>]]>''';

    String soap = '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
        <soapenv:Body>
            <urn:ZIF_WQ_IN_WS>
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
    return BillModel.xml2List(outputxmlstr);
  }
}
