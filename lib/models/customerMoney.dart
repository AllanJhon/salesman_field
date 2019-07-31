import 'package:xml/xml.dart' as xml;

class CustomerMoney {
  bool isSucess;
  String message;
  String qydw;
  String money;  //dmbtr4 应收账款余额
  String ddwqje;// 订单未提金额
  List customerMoneyList;

  CustomerMoney(
    this.isSucess,
    this.message,
    this.qydw,
    this.money,
    this.ddwqje,
  );

//butxt 公司描述，dmbtr4 应收账款期末余额，ddwqje 订单未清到位价金额，jhwqje 交货到位价未清金额，fpwqje 发票到位价未清金额
  CustomerMoney.xml2List(outputxmlstr) {
    List list = xml
        .parse(outputxmlstr)
        .findAllElements('RESULT')
        .map((node) => node.findElements('Status').single.text)
        .toList();
    if (list.length > 0) {
      if (list[0] == "S") {
        customerMoneyList = xml
            .parse(outputxmlstr)
            .findAllElements('DATA')
            .map((node) => new CustomerMoney(
                true,
                "",
                node.findElements('butxt').single.text,
                node.findElements('dmbtr4').single.text,
                node.findElements('ddwqje').single.text)).toList();
      } else {
        customerMoneyList = xml
            .parse(outputxmlstr)
            .findAllElements('RESULT')
            .map((node) => new CustomerMoney(
                false,
                node.findElements('Message').single.text,
                "error",
                "error",
                "error"))
            .toList();
      }
    }
  }
}
