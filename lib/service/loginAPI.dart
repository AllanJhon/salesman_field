import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../models/loginUser.dart';
import '../data/SAPCONST.dart';
import 'package:connectivity/connectivity.dart';

class LoginAPI {
  static Future<LoginUser> login(String user, String pwd,
      {String funcName = "userLogin", String newPwd = "123456"}) async {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
    String md5Sign =
        md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
    String inputxmlstr;
    inputxmlstr = '''<![CDATA[<?xml version="1.0" encoding="UTF-8"?>
            <data>
              <user_name>$user</user_name>
              <password>$pwd</password>
              <new_password>$newPwd</new_password>
            </data>]]>''';
    String soap = '''
        <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://sales.open.ttx.io/">
        <soap:Header/>
        <soap:Body>
            <sal:$funcName>
              <sal:inputTimestamp>$timestamp</sal:inputTimestamp>
              <sal:inputSign>$md5Sign</sal:inputSign>
              <sal:inputSecrect>249VOELF82CD</sal:inputSecrect>
              <sal:inputXmlStr>$inputxmlstr</sal:inputXmlStr>
            </sal:$funcName>
        </soap:Body>
        </soap:Envelope>''';

    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);

    if ((connectivityResult != ConnectivityResult.mobile) &&
        (connectivityResult != ConnectivityResult.wifi)) {
      LoginUser loginUser =
          new LoginUser("", "", "", "", "", "", false, "您需要连接网络才能使用系统。");
      loginUser.loginUserList = [loginUser];
      return loginUser;
    }

    try {
      var response = await http.post(
          Uri.parse(getSelfURL() + "/services/userApiServiceV1?wsdl"),
          body: utf8.encode(soap),
          encoding: Encoding.getByName("UTF-8"));

      if (response.statusCode != 200) {
        LoginUser loginUser = new LoginUser("", "", "", "", "", "", false,
            "网络异常: " + response.statusCode.toString());
        loginUser.loginUserList = [loginUser];
        return loginUser;
      }

      var document = xml.parse(response.body);
      var outputxmlstr = document.findAllElements('ns:return').single.text;

      return LoginUser.xml2List(outputxmlstr);
    } catch (exception) {
      return null;
    }
  }
}
