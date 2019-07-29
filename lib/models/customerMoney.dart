import 'package:xml/xml.dart' as xml;

class CustomerMoney {
  bool isSucess;
  String message;
  String qydw;
  String money;
  List customerMoneyList;

  CustomerMoney(
    this.isSucess,
    this.message,
    this.qydw,
    this.money,
  );

  CustomerMoney.xml2List(outputxmlstr) {
    // print(xml.parse(outputxmlstr).findAllElements('details'));
    List list = xml
        .parse(outputxmlstr)
        .findAllElements('RESULT')
        .map((node) => node.findElements('STATUS').single.text)
        .toList();
    if (list.length > 0) {
      if (list[0] == "S") {
        customerMoneyList = xml
            .parse(outputxmlstr)
            .findAllElements('contract')
            .map((node) => new CustomerMoney(
                true,
                "",
                node.findElements('approveStatus').single.text,
                node.findElements('jsfs').single.text)).toList();
      } else {
        customerMoneyList = xml
            .parse(outputxmlstr)
            .findAllElements('DATA')
            .map((node) => new CustomerMoney(
                false,
                node.findElements('MESSAGE').single.text,
                "error",
                "error"))
            .toList();
      }
    }
  }
}
