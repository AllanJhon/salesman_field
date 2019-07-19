import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/customer.dart';
import '../models/loginUser.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../data/SAPCONST.dart';

class CustomerAPI {

  // Future<Customer> getCustomerList(int start) async {
  //   var client = HttpClient();
  //   var request = await client.getUrl(Uri.parse(
  //       'http://10.0.65.171:8180/dataQuery/getCustomerListApi.do?title=%E5%86%80%E4%B8%9C&time=699&page=1&start=0&limit=20'));
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   Map<String,Object> data = json.decode(responseBody);
  //   // print(data['rows']);
  //   return Customer.fromJSON(data);
  // }

  // static Future<Customer> getCustomerList(String sales_code, String sales_office,String year) async {
    static Future<Customer> getCustomerList(int year) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr = '''<![CDATA[<?xml version="1.0" encoding="UTF-8"?>
            <data>
              <sales_code>${currentUser.salesCode}</sales_code>
              <sales_office>${currentUser.salesOffice}</sales_office>
              <year>${date.year.toString()}</year>
            </data>]]>''';
    String soap = '''
        <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://sales.open.ttx.io/">
        <soap:Header/>
        <soap:Body>
            <sal:getCustomer>
              <sal:inputTimestamp>$timestamp</sal:inputTimestamp>
              <sal:inputSign>$md5Sign</sal:inputSign>
              <sal:inputSecrect>249VOELF82CD</sal:inputSecrect>
              <sal:inputXmlStr>$inputxmlstr</sal:inputXmlStr>
            </sal:getCustomer>
        </soap:Body>
        </soap:Envelope>''';

    var response = await http.post(
        Uri.parse(getSelfURL()+"customerApiServiceV1?wsdl"),
        // Uri.parse("http://192.168.0.106/sales/services/customerApiServiceV1?wsdl"),
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));

    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
      return null;
    }
    var document = xml.parse(response.body);
    var outputxmlstr = document.findAllElements('ns:return').single.text;
    return Customer.xml2List(outputxmlstr);
  }
}