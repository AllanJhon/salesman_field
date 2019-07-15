import 'package:xml/xml.dart' as xml;

LoginUser currentUser;

class LoginUser {
  String userName;
  String displayName;
  String userId;
  String salesCode; //销售员编码
  String salesOffice; //销售办公室编码
  String password;
  bool isSucess;
  String error;
  List loginUserList;

  LoginUser(this.userName, this.displayName, this.userId, this.salesCode,
      this.salesOffice, this.password, this.isSucess, this.error);

  LoginUser.xml2List(outputxmlstr) {
    List list = xml
        .parse(outputxmlstr)
        .findAllElements('response')
        .map((node) => node.findElements('success').single.text)
        .toList();

    if (list.length > 0) {
      if (list[0] == "true") {
        loginUserList = xml
            .parse(outputxmlstr)
            .findAllElements('data')
            .map((node) => new LoginUser(
                  node.findElements('user_name').single.text,
                  node.findElements('display_name').single.text,
                  node.findElements('user_id').single.text,
                  node.findElements('sales_code').single.text,
                  node.findElements('sales_office').single.text,
                  node.findElements('password').single.text,
                  true,
                  '',
                ))
            .toList();
      } else {
        loginUserList = xml
            .parse(outputxmlstr)
            .findAllElements('response')
            .map((node) => new LoginUser(
                  'error',
                  'error',
                  'error',
                  'error',
                  'error',
                  'error',
                  false,
                  node.findElements('error').single.text,
                ))
            .toList();
      }
      currentUser = loginUserList[0];
    }
  }
}
