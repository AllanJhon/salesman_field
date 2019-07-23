import 'package:xml/xml.dart' as xml;

class Contract4OA {
  bool isSucess;
  String message;
  String approveStatus;
  String jsfs;
  String customerTitle;
  String sqrq;
  String qdzl;
  String ysfs;
  String approver;
  String qydw;
  // ContractDetail detail;
  List contract4OAList;

  Contract4OA(
      this.isSucess,
      this.message,
      this.approveStatus,
      this.jsfs,
      this.customerTitle,
      this.sqrq,
      this.qdzl,
      this.ysfs,
      this.approver,
      this.qydw,
      // this.detail
      );

  Contract4OA.xml2List(outputxmlstr) {
    List list = xml
        .parse(outputxmlstr)
        .findAllElements('RESULT')
        .map((node) => node.findElements('STATUS').single.text)
        .toList();
    if (list.length > 0) {
      if (list[0] == "S") {
        contract4OAList = xml
            .parse(outputxmlstr)
            .findAllElements('contract')
            .map((node) => new Contract4OA(
                true,
                "",
                node.findElements('approveStatus').single.text,
                node.findElements('jsfs').single.text,
                node.findElements('customer_title').single.text,
                node.findElements('sqrq').single.text,
                node.findElements('qdzl').single.text,
                node.findElements('ysfs').single.text,
                node.findElements('approver').single.text,
                node.findElements('qydw').single.text))
            .toList();
      } else {
        contract4OAList = xml
            .parse(outputxmlstr)
            .findAllElements('DATA')
            .map((node) => new Contract4OA(
                false,
                node.findElements('MESSAGE').single.text,
                "error",
                "error",
                "error",
                "error",
                "error",
                "error",
                "error",
                "error"))
            .toList();
      }
    }
  }
}

  class ContractDetail{
    String pz;
    String hkdj;
    String yfj;
    String fhcj;
  }
